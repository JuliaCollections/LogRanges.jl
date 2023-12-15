module LogRanges

export LogRange, logrange

"""
    logrange(start, stop, length)
    logrange(start, stop; length)

Construct a specialized array whose elements are spaced logarithmically
between the given endpoints. That is, the ratio of successive elements is
a constant, calculated from the length.

This is similar to `geomspace` in Python. Unlike `PowerRange` in Mathematica,
you specify the number of elements not the ratio.
Unlike `logspace` in Python and Matlab, the `start` and `stop` arguments are
always the first and last elements of the result, not powers applied to some base.

See also [`range`](@ref) for linearly spaced points.

# Examples
```jldoctest
julia> logrange(10, 4000, length=3)
3-element LogRange{Float64, Base.TwicePrecision{Float64}}:
 10.0, 200.0, 4000.0

julia> ans[2] ≈ sqrt(10 * 4000)  # middle element is the geometric mean
true

julia> range(10, 40, length=3)[2] ≈ (10 + 40)/2  # arithmetic mean
true

julia> logrange(1f0, 32f0, 11)
11-element LogRange{Float32, Float64}:
 1.0, 1.41421, 2.0, 2.82843, 4.0, 5.65685, 8.0, 11.3137, 16.0, 22.6274, 32.0

julia> logrange(1, 1000, length=4) ≈ 10 .^ (0:3)
true

julia> logrange(-27, -3, length=7)  # allows negative numbers
7-element LogRange{Float64, Base.TwicePrecision{Float64}}:
 -27.0, -18.7208, -12.9802, -9.0, -6.24025, -4.32675, -3.0
```

!!! compat "Julia 1.10"
    This function requires at least Julia 1.10.
"""
logrange(start::Number, stop::Number, length::Integer) = LogRange(start, stop, Int(length))
logrange(start::Number, stop::Number; length::Integer) = LogRange(start, stop, Int(length))


"""
    LogRange{T}(start, stop, len) <: AbstractVector{T}

A range whose elements are spaced logarithmically between `start` and `stop`,
with spacing controlled by `len`. Returned by [`logrange`](@ref).

Like [`LinRange`](@ref), the first and last elements will be exactly those
provided, but intermediate values may have small floating-point errors.
These are calculated using the logs of the endpoints, which are
stored on construction, often in higher precision than `T`.

Negative values of `start` and `stop` are allowed, but both must have the
same sign. For complex `T`, all points lie on the same branch of `log`
as used by `log(start)` and `log(stop)`.

# Examples
```jldoctest
julia> LogRange(1, 4, 5)
5-element LogRange{Float64, Base.TwicePrecision{Float64}}:
 1.0, 1.41421, 2.0, 2.82843, 4.0

julia> LogRange{Float16}(-1, -4, 5)
5-element LogRange{Float16, Float64}:
 -1.0, -1.414, -2.0, -2.828, -4.0

julia> LogRange(1e-310, 1e-300, 11)[1:2:end]
6-element Vector{Float64}:
 1.0e-310
 9.999999999999974e-309
 9.999999999999981e-307
 9.999999999999988e-305
 9.999999999999994e-303
 1.0e-300

julia> prevfloat(1e-308, 5) == ans[2]
true

julia> LogRange{ComplexF32}(1, -1 +0.0im, 5) |> collect
5-element Vector{ComplexF32}:
         1.0f0 + 0.0f0im
  0.70710677f0 + 0.70710677f0im
  6.123234f-17 + 1.0f0im
 -0.70710677f0 + 0.70710677f0im
        -1.0f0 + 0.0f0im

julia> ans ≈ cis.(LinRange{Float32}(0, pi, 5))
true

julia> LogRange(2, Inf, 5)
5-element LogRange{Float64, Base.TwicePrecision{Float64}}:
 2.0, Inf, Inf, Inf, Inf

julia> LogRange(0, 4, 5)
5-element LogRange{Float64, Base.TwicePrecision{Float64}}:
 NaN, NaN, NaN, NaN, 4.0
```

!!! compat "Julia 1.10"
    This type requires at least Julia 1.10.
"""
struct LogRange{T<:Number,X} <: AbstractArray{T,1}
    start::T
    stop::T
    len::Int
    extra::Tuple{X,X}
    function LogRange{T}(start::T, stop::T, length::Int) where {T<:Number}
        # LogRange(0, 1, 100) could be == [0,0,0,0,...,1], that's the limit start -> 0,
        # but seems more likely to give silent surprises than returning NaN.
        a = iszero(start) ? T(NaN) : T(start)
        b = iszero(stop) ? T(NaN) : T(stop)
        len = Int(length)
        if len < 0
            throw(ArgumentError(LazyString(
                "LogRange(", start, ", ", stop, ", ", len, "): can't have negative length")))
        elseif len == 1 && start != stop
            throw(ArgumentError(LazyString(
                "LogRange(", start, ", ", stop, ", ", len, "): endpoints differ, while length is 1")))
        elseif iszero(start) || iszero(stop)
        elseif T <: Real && (start<0) ⊻ (stop<0)
            throw(DomainError((start, stop),
                "LogRange will only return complex results if called with a complex argument"))
        end
        if T <: Integer || T <: Complex{<:Integer}
            # LogRange{Int}(1, 512, 4) produces InexactError: Int64(7.999999999999998)
            throw(ArgumentError("LogRange{T} does not support integer types"))
        end
        ex = if T <: Real && start + stop < 0  # start+stop allows for LogRange(-0.0, -2, 3)
            _logrange_extra(-a, -b, len)
        else
            _logrange_extra(a, b, len)
        end
        new{T,typeof(ex[1])}(a, b, len, ex)
    end
end

function LogRange{T}(start::Number, stop::Number, len::Integer) where {T}
    LogRange{T}(convert(T, start), convert(T, stop), convert(Int, len))
end
function LogRange(start::Number, stop::Number, len::Integer)
    T = float(promote_type(typeof(start), typeof(stop)))
    LogRange{T}(convert(T, start), convert(T, stop), convert(Int, len))
end

Base.size(r::LogRange) = (r.len,)

Base.first(r::LogRange) = r.start
Base.last(r::LogRange) = r.stop

function _logrange_extra(a::Number, b::Number, len::Int)
    loga = log(1.0 * a)  # widen to at least Float64
    logb = log(1.0 * b)
    (loga/(len-1), logb/(len-1))
end
function _logrange_extra(a::Float64, b::Float64, len::Int)
    loga = _log_twice64_unchecked(a)
    logb = _log_twice64_unchecked(b)
    # The reason not to do linear interpolation on log(a)..log(b) in `getindex` is
    # that division of TwicePrecision is quite slow, so do it once on construction:
    (loga/(len-1), logb/(len-1))
end

function Base.getindex(r::LogRange{T}, i::Int) where {T}
    @inline
    @boundscheck checkbounds(r, i)
    i == 1 && return r.start
    i == r.len && return r.stop
    tot = r.start + r.stop
    isfinite(tot) || return tot
    # Main path uses Math.exp_impl for TwicePrecision, but is not perfectly
    # accurate, nor does it handle NaN/Inf as desired, hence the cases above.
    logx = (r.len-i) * r.extra[1] + (i-1) * r.extra[2]
    x = _exp_allowing_twice64(logx)
    return T <: Real ? copysign(T(x), r.start) : T(x)
end

function Base.show(io::IO, r::LogRange{T}) where {T}
    print(io, "LogRange{", T, "}(")
    ioc = IOContext(io, :typeinfo => T)
    show(ioc, first(r))
    print(io, ", ")
    show(ioc, last(r))
    print(io, ", ")
    show(io, length(r))
    print(io, ')')
end


#######



function print_range(io::IO, r::AbstractArray,
                     pre::AbstractString = " ",
                     sep::AbstractString = ", ",
                     post::AbstractString = "",
                     hdots::AbstractString = ", \u2026, ") # horiz ellipsis
    # This function borrows from print_matrix() in show.jl
    # and should be called by show and display
    sz = displaysize(io)
    if !haskey(io, :compact)
        io = IOContext(io, :compact => true)
    end
    screenheight, screenwidth = sz[1] - 4, sz[2]
    screenwidth -= length(pre) + length(post)
    postsp = ""
    sepsize = length(sep)
    m = 1 # treat the range as a one-row matrix
    n = length(r)
    # Figure out spacing alignments for r, but only need to examine the
    # left and right edge columns, as many as could conceivably fit on the
    # screen, with the middle columns summarized by horz, vert, or diag ellipsis
    maxpossiblecols = div(screenwidth, 1+sepsize) # assume each element is at least 1 char + 1 separator
    colsr = n <= maxpossiblecols ? (1:n) : [1:div(maxpossiblecols,2)+1; (n-div(maxpossiblecols,2)):n]
    rowmatrix = reshape(r[colsr], 1, length(colsr)) # treat the range as a one-row matrix for print_matrix_row
    nrow, idxlast = size(rowmatrix, 2), last(axes(rowmatrix, 2))
    A = Base.alignment(io, rowmatrix, 1:m, 1:length(rowmatrix), screenwidth, screenwidth, sepsize, nrow) # how much space range takes
    if n <= length(A) # cols fit screen, so print out all elements
        print(io, pre) # put in pre chars
        Base.print_matrix_row(io,rowmatrix,A,1,1:n,sep,idxlast) # the entire range
        print(io, post) # add the post characters
    else # cols don't fit so put horiz ellipsis in the middle
        # how many chars left after dividing width of screen in half
        # and accounting for the horiz ellipsis
        c = div(screenwidth-length(hdots)+1,2)+1 # chars remaining for each side of rowmatrix
        alignR = reverse(Base.alignment(io, rowmatrix, 1:m, length(rowmatrix):-1:1, c, c, sepsize, nrow)) # which cols of rowmatrix to put on the right
        c = screenwidth - sum(map(sum,alignR)) - (length(alignR)-1)*sepsize - length(hdots)
        alignL = Base.alignment(io, rowmatrix, 1:m, 1:length(rowmatrix), c, c, sepsize, nrow) # which cols of rowmatrix to put on the left
        print(io, pre)   # put in pre chars
        Base.print_matrix_row(io, rowmatrix,alignL,1,1:length(alignL),sep,idxlast) # left part of range
        print(io, hdots) # horizontal ellipsis
        Base.print_matrix_row(io, rowmatrix,alignR,1,length(rowmatrix)-length(alignR)+1:length(rowmatrix),sep,idxlast) # right part of range
        print(io, post)  # post chars
    end
end



#######



function Base.show(io::IO, ::MIME"text/plain", r::LogRange)  # display LogRange like LinRange
    isempty(r) && return show(io, r)
    summary(io, r)
    println(io, ":")
    print_range(io, r, " ", ", ", "", " \u2026 ")
end



######



# These functions exist for use in LogRange:

_exp_allowing_twice64(x::Number) = exp(x)
_exp_allowing_twice64(x::Base.TwicePrecision{Float64}) = Base.Math.exp_impl(x.hi, x.lo, Val(:ℯ))

# No error on negative x, and for NaN/Inf this returns junk:
function _log_twice64_unchecked(x::Float64)
    xu = reinterpret(UInt64, x)
    if xu < (UInt64(1)<<52) # x is subnormal
        xu = reinterpret(UInt64, x * 0x1p52) # normalize x
        xu &= ~Base.sign_mask(Float64)
        xu -= UInt64(52) << 52 # mess with the exponent
    end
    Base.TwicePrecision(Base.Math._log_ext(xu)...)
end

end
