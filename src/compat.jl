
if VERSION < v"1.8"
    LazyString(args...) = join(string.(args))
end

const J_TABLE = (0x0000000000000000, 0xaac00b1afa5abcbe, 0x9b60163da9fb3335, 0xab502168143b0280, 0xadc02c9a3e778060,
                 0x656037d42e11bbcc, 0xa7a04315e86e7f84, 0x84c04e5f72f654b1, 0x8d7059b0d3158574, 0xa510650a0e3c1f88,
                 0xa8d0706b29ddf6dd, 0x83207bd42b72a836, 0x6180874518759bc8, 0xa4b092bdf66607df, 0x91409e3ecac6f383,
                 0x85d0a9c79b1f3919, 0x98a0b5586cf9890f, 0x94f0c0f145e46c85, 0x9010cc922b7247f7, 0xa210d83b23395deb,
                 0x4030e3ec32d3d1a2, 0xa5b0efa55fdfa9c4, 0xae40fb66affed31a, 0x8d41073028d7233e, 0xa4911301d0125b50,
                 0xa1a11edbab5e2ab5, 0xaf712abdc06c31cb, 0xae8136a814f204aa, 0xa661429aaea92ddf, 0xa9114e95934f312d,
                 0x82415a98c8a58e51, 0x58f166a45471c3c2, 0xab9172b83c7d517a, 0x70917ed48695bbc0, 0xa7718af9388c8de9,
                 0x94a1972658375d2f, 0x8e51a35beb6fcb75, 0x97b1af99f8138a1c, 0xa351bbe084045cd3, 0x9001c82f95281c6b,
                 0x9e01d4873168b9aa, 0xa481e0e75eb44026, 0xa711ed5022fcd91c, 0xa201f9c18438ce4c, 0x8dc2063b88628cd6,
                 0x935212be3578a819, 0x82a21f49917ddc96, 0x8d322bdda27912d1, 0x99b2387a6e756238, 0x8ac2451ffb82140a,
                 0x8ac251ce4fb2a63f, 0x93e25e85711ece75, 0x82b26b4565e27cdd, 0x9e02780e341ddf29, 0xa2d284dfe1f56380,
                 0xab4291ba7591bb6f, 0x86129e9df51fdee1, 0xa352ab8a66d10f12, 0xafb2b87fd0dad98f, 0xa572c57e39771b2e,
                 0x9002d285a6e4030b, 0x9d12df961f641589, 0x71c2ecafa93e2f56, 0xaea2f9d24abd886a, 0x86f306fe0a31b715,
                 0x89531432edeeb2fd, 0x8a932170fc4cd831, 0xa1d32eb83ba8ea31, 0x93233c08b26416ff, 0xab23496266e3fa2c,
                 0xa92356c55f929ff0, 0xa8f36431a2de883a, 0xa4e371a7373aa9ca, 0xa3037f26231e7549, 0xa0b38cae6d05d865,
                 0xa3239a401b7140ee, 0xad43a7db34e59ff6, 0x9543b57fbfec6cf4, 0xa083c32dc313a8e4, 0x7fe3d0e544ede173,
                 0x8ad3dea64c123422, 0xa943ec70df1c5174, 0xa413fa4504ac801b, 0x8bd40822c367a024, 0xaf04160a21f72e29,
                 0xa3d423fb27094689, 0xab8431f5d950a896, 0x88843ffa3f84b9d4, 0x48944e086061892d, 0xae745c2042a7d231,
                 0x9c946a41ed1d0057, 0xa1e4786d668b3236, 0x73c486a2b5c13cd0, 0xab1494e1e192aed1, 0x99c4a32af0d7d3de,
                 0xabb4b17dea6db7d6, 0x7d44bfdad5362a27, 0x9054ce41b817c114, 0x98e4dcb299fddd0d, 0xa564eb2d81d8abfe,
                 0xa5a4f9b2769d2ca6, 0x7a2508417f4531ee, 0xa82516daa2cf6641, 0xac65257de83f4eee, 0xabe5342b569d4f81,
                 0x879542e2f4f6ad27, 0xa8a551a4ca5d920e, 0xa7856070dde910d1, 0x99b56f4736b527da, 0xa7a57e27dbe2c4ce,
                 0x82958d12d497c7fd, 0xa4059c0827ff07cb, 0x9635ab07dd485429, 0xa245ba11fba87a02, 0x3c45c9268a5946b7,
                 0xa195d84590998b92, 0x9ba5e76f15ad2148, 0xa985f6a320dceb70, 0xa60605e1b976dc08, 0x9e46152ae6cdf6f4,
                 0xa636247eb03a5584, 0x984633dd1d1929fd, 0xa8e6434634ccc31f, 0xa28652b9febc8fb6, 0xa226623882552224,
                 0xa85671c1c70833f5, 0x60368155d44ca973, 0x880690f4b19e9538, 0xa216a09e667f3bcc, 0x7a36b052fa75173e,
                 0xada6c012750bdabe, 0x9c76cfdcddd47645, 0xae46dfb23c651a2e, 0xa7a6ef9298593ae4, 0xa9f6ff7df9519483,
                 0x59d70f7466f42e87, 0xaba71f75e8ec5f73, 0xa6f72f8286ead089, 0xa7a73f9a48a58173, 0x90474fbd35d7cbfd,
                 0xa7e75feb564267c8, 0x9b777024b1ab6e09, 0x986780694fde5d3f, 0x934790b938ac1cf6, 0xaaf7a11473eb0186,
                 0xa207b17b0976cfda, 0x9f17c1ed0130c132, 0x91b7d26a62ff86f0, 0x7057e2f336cf4e62, 0xabe7f3878491c490,
                 0xa6c80427543e1a11, 0x946814d2add106d9, 0xa1582589994cce12, 0x9998364c1eb941f7, 0xa9c8471a4623c7ac,
                 0xaf2857f4179f5b20, 0xa01868d99b4492ec, 0x85d879cad931a436, 0x99988ac7d98a6699, 0x9d589bd0a478580f,
                 0x96e8ace5422aa0db, 0x9ec8be05bad61778, 0xade8cf3216b5448b, 0xa478e06a5e0866d8, 0x85c8f1ae99157736,
                 0x959902fed0282c8a, 0xa119145b0b91ffc5, 0xab2925c353aa2fe1, 0xae893737b0cdc5e4, 0xa88948b82b5f98e4,
                 0xad395a44cbc8520e, 0xaf296bdd9a7670b2, 0xa1797d829fde4e4f, 0x7ca98f33e47a22a2, 0xa749a0f170ca07b9,
                 0xa119b2bb4d53fe0c, 0x7c79c49182a3f090, 0xa579d674194bb8d4, 0x7829e86319e32323, 0xaad9fa5e8d07f29d,
                 0xa65a0c667b5de564, 0x9c6a1e7aed8eb8bb, 0x963a309bec4a2d33, 0xa2aa42c980460ad7, 0xa16a5503b23e255c,
                 0x650a674a8af46052, 0x9bca799e1330b358, 0xa58a8bfe53c12e58, 0x90fa9e6b5579fdbf, 0x889ab0e521356eba,
                 0xa81ac36bbfd3f379, 0x97ead5ff3a3c2774, 0x97aae89f995ad3ad, 0xa5aafb4ce622f2fe, 0xa21b0e07298db665,
                 0x94db20ce6c9a8952, 0xaedb33a2b84f15fa, 0xac1b468415b749b0, 0xa1cb59728de55939, 0x92ab6c6e29f1c52a,
                 0xad5b7f76f2fb5e46, 0xa24b928cf22749e3, 0xa08ba5b030a10649, 0xafcbb8e0b79a6f1e, 0x823bcc1e904bc1d2,
                 0xafcbdf69c3f3a206, 0xa08bf2c25bd71e08, 0xa89c06286141b33c, 0x811c199bdd85529c, 0xa48c2d1cd9fa652b,
                 0x9b4c40ab5fffd07a, 0x912c544778fafb22, 0x928c67f12e57d14b, 0xa86c7ba88988c932, 0x71ac8f6d9406e7b5,
                 0xaa0ca3405751c4da, 0x750cb720dcef9069, 0xac5ccb0f2e6d1674, 0xa88cdf0b555dc3f9, 0xa2fcf3155b5bab73,
                 0xa1ad072d4a07897b, 0x955d1b532b08c968, 0xa15d2f87080d89f1, 0x93dd43c8eacaa1d6, 0x82ed5818dcfba487,
                 0x5fed6c76e862e6d3, 0xa77d80e316c98397, 0x9a0d955d71ff6075, 0x9c2da9e603db3285, 0xa24dbe7cd63a8314,
                 0x92ddd321f301b460, 0xa1ade7d5641c0657, 0xa72dfc97337b9b5e, 0xadae11676b197d16, 0xa42e264614f5a128,
                 0xa30e3b333b16ee11, 0x839e502ee78b3ff6, 0xaa7e653924676d75, 0x92de7a51fbc74c83, 0xa77e8f7977cdb73f,
                 0xa0bea4afa2a490d9, 0x948eb9f4867cca6e, 0xa1becf482d8e67f0, 0x91cee4aaa2188510, 0x9dcefa1bee615a27,
                 0xa66f0f9c1cb64129, 0x93af252b376bba97, 0xacdf3ac948dd7273, 0x99df50765b6e4540, 0x9faf6632798844f8,
                 0xa12f7bfdad9cbe13, 0xaeef91d802243c88, 0x874fa7c1819e90d8, 0xacdfbdba3692d513, 0x62efd3c22b8f71f1, 0x74afe9d96b2a23d9)
const JU_MASK = typemax(UInt64)>>12
const JU_CONST = 0x3FF0000000000000
const JL_CONST = 0x3C00000000000000

function table_unpack(ind::Int32)
    ind = ind & 255 + 1 # 255 == length(J_TABLE) - 1
    j = getfield(J_TABLE, ind) # use getfield so the compiler can prove consistent
    jU = reinterpret(Float64, JU_CONST | (j&JU_MASK))
    jL = reinterpret(Float64, JL_CONST | (j>>8))
    return jU, jL
end

function expm1b_kernel(::Val{:ℯ}, x::Float64)
    return x * evalpoly(x, (0.9999999999999912, 0.4999999999999997,
                            0.1666666857598779, 0.04166666857598777))
end

MAGIC_ROUND_CONST(::Type{Float64}) = 6.755399441055744e15
MAX_EXP(n::Val{:ℯ}, ::Type{Float64}) = 709.7827128933841
MIN_EXP(n::Val{:ℯ}, ::Type{Float64}) = -745.1332191019412
SUBNORM_EXP(n::Val{:ℯ}, ::Type{Float64}) = 708.3964185322641
LogBo256INV(::Val{:ℯ}, ::Type{Float64}) = 369.3299304675746
LogBo256U(::Val{:ℯ}, ::Type{Float64}) = -0.002707606173999011
LogBo256L(::Val{:ℯ}, ::Type{Float64}) = -6.327543041662719e-14

@inline function exp_impl(x::Float64, xlo::Float64, base)
    T = Float64
    N_float = muladd(x, LogBo256INV(base, T), MAGIC_ROUND_CONST(T))
    N = reinterpret(UInt64, N_float) % Int32
    N_float -=  MAGIC_ROUND_CONST(T) #N_float now equals round(x*LogBo256INV(base, T))
    r = muladd(N_float, LogBo256U(base, T), x)
    r = muladd(N_float, LogBo256L(base, T), r)
    k = N >> 8
    jU, jL = table_unpack(N)
    very_small = muladd(jU, expm1b_kernel(base, r), jL)
    small_part =  muladd(jU,xlo,very_small) + jU
    if !(abs(x) <= SUBNORM_EXP(base, T))
        x >= MAX_EXP(base, T) && return Inf
        x <= MIN_EXP(base, T) && return 0.0
        if k <= -53
            # The UInt64 forces promotion. (Only matters for 32 bit systems.)
            twopk = (k + UInt64(53)) << 52
            return reinterpret(T, twopk + reinterpret(UInt64, small_part))*0x1p-53
        end
        #k == 1024 && return (small_part * 2.0) * 2.0^1023
    end
    twopk = Int64(k) << 52
    return reinterpret(T, twopk + reinterpret(Int64, small_part))
end

#function make_compact_table(N)
#    table = Tuple{UInt64,Float64}[]
#    lo, hi = 0x1.69555p-1, 0x1.69555p0
#    for i in 0:N-1
#        # I am not fully sure why this is the right formula to use, but it apparently is
#        center = i/(2*N) + lo < 1 ? (i+.5)/(2*N) + lo : (i+.5)/N + hi -1
#        invc = Float64(center < 1 ? round(N/center)/N : round(2*N/center)/(N*2))
#        c = inv(big(invc))
#        logc = Float64(round(0x1p43*log(c))/0x1p43)
#        logctail = reinterpret(Float64, Float64(log(c) - logc))
#        p1 = (reinterpret(UInt64,invc) >> 45) % UInt8
#        push!(table, (p1|reinterpret(UInt64,logc),logctail))
#    end
#    return Tuple(table)
#end
#const t_log_table_compact = make_compact_table(128)
const t_log_table_compact = (
    (0xbfd62c82f2b9c8b5, 5.929407345889625e-15),
    (0xbfd5d1bdbf5808b4, -2.544157440035963e-14),
    (0xbfd57677174558b3, -3.443525940775045e-14),
    (0xbfd51aad872df8b2, -2.500123826022799e-15),
    (0xbfd4be5f957778b1, -8.929337133850617e-15),
    (0xbfd4618bc21c60b0, 1.7625431312172662e-14),
    (0xbfd404308686a8af, 1.5688303180062087e-15),
    (0xbfd3a64c556948ae, 2.9655274673691784e-14),
    (0xbfd347dd9a9880ad, 3.7923164802093147e-14),
    (0xbfd2e8e2bae120ac, 3.993416384387844e-14),
    (0xbfd2895a13de88ab, 1.9352855826489123e-14),
    (0xbfd2895a13de88ab, 1.9352855826489123e-14),
    (0xbfd22941fbcf78aa, -1.9852665484979036e-14),
    (0xbfd1c898c16998a9, -2.814323765595281e-14),
    (0xbfd1675cababa8a8, 2.7643769993528702e-14),
    (0xbfd1058bf9ae48a7, -4.025092402293806e-14),
    (0xbfd0a324e27390a6, -1.2621729398885316e-14),
    (0xbfd0402594b4d0a5, -3.600176732637335e-15),
    (0xbfd0402594b4d0a5, -3.600176732637335e-15),
    (0xbfcfb9186d5e40a4, 1.3029797173308663e-14),
    (0xbfcef0adcbdc60a3, 4.8230289429940886e-14),
    (0xbfce27076e2af0a2, -2.0592242769647135e-14),
    (0xbfcd5c216b4fc0a1, 3.149265065191484e-14),
    (0xbfcc8ff7c79aa0a0, 4.169796584527195e-14),
    (0xbfcc8ff7c79aa0a0, 4.169796584527195e-14),
    (0xbfcbc286742d909f, 2.2477465222466186e-14),
    (0xbfcaf3c94e80c09e, 3.6507188831790577e-16),
    (0xbfca23bc1fe2b09d, -3.827767260205414e-14),
    (0xbfca23bc1fe2b09d, -3.827767260205414e-14),
    (0xbfc9525a9cf4509c, -4.7641388950792196e-14),
    (0xbfc87fa06520d09b, 4.9278276214647115e-14),
    (0xbfc7ab890210e09a, 4.9485167661250996e-14),
    (0xbfc7ab890210e09a, 4.9485167661250996e-14),
    (0xbfc6d60fe719d099, -1.5003333854266542e-14),
    (0xbfc5ff3070a79098, -2.7194441649495324e-14),
    (0xbfc5ff3070a79098, -2.7194441649495324e-14),
    (0xbfc526e5e3a1b097, -2.99659267292569e-14),
    (0xbfc44d2b6ccb8096, 2.0472357800461955e-14),
    (0xbfc44d2b6ccb8096, 2.0472357800461955e-14),
    (0xbfc371fc201e9095, 3.879296723063646e-15),
    (0xbfc29552f81ff094, -3.6506824353335045e-14),
    (0xbfc1b72ad52f6093, -5.4183331379008994e-14),
    (0xbfc1b72ad52f6093, -5.4183331379008994e-14),
    (0xbfc0d77e7cd09092, 1.1729485484531301e-14),
    (0xbfc0d77e7cd09092, 1.1729485484531301e-14),
    (0xbfbfec9131dbe091, -3.811763084710266e-14),
    (0xbfbe27076e2b0090, 4.654729747598445e-14),
    (0xbfbe27076e2b0090, 4.654729747598445e-14),
    (0xbfbc5e548f5bc08f, -2.5799991283069902e-14),
    (0xbfba926d3a4ae08e, 3.7700471749674615e-14),
    (0xbfba926d3a4ae08e, 3.7700471749674615e-14),
    (0xbfb8c345d631a08d, 1.7306161136093256e-14),
    (0xbfb8c345d631a08d, 1.7306161136093256e-14),
    (0xbfb6f0d28ae5608c, -4.012913552726574e-14),
    (0xbfb51b073f06208b, 2.7541708360737882e-14),
    (0xbfb51b073f06208b, 2.7541708360737882e-14),
    (0xbfb341d7961be08a, 5.0396178134370583e-14),
    (0xbfb341d7961be08a, 5.0396178134370583e-14),
    (0xbfb16536eea38089, 1.8195060030168815e-14),
    (0xbfaf0a30c0118088, 5.213620639136504e-14),
    (0xbfaf0a30c0118088, 5.213620639136504e-14),
    (0xbfab42dd71198087, 2.532168943117445e-14),
    (0xbfab42dd71198087, 2.532168943117445e-14),
    (0xbfa77458f632c086, -5.148849572685811e-14),
    (0xbfa77458f632c086, -5.148849572685811e-14),
    (0xbfa39e87b9fec085, 4.6652946995830086e-15),
    (0xbfa39e87b9fec085, 4.6652946995830086e-15),
    (0xbf9f829b0e780084, -4.529814257790929e-14),
    (0xbf9f829b0e780084, -4.529814257790929e-14),
    (0xbf97b91b07d58083, -4.361324067851568e-14),
    (0xbf8fc0a8b0fc0082, -1.7274567499706107e-15),
    (0xbf8fc0a8b0fc0082, -1.7274567499706107e-15),
    (0xbf7fe02a6b100081, -2.298941004620351e-14),
    (0xbf7fe02a6b100081, -2.298941004620351e-14),
    (0x0000000000000080, 0.0),
    (0x0000000000000080, 0.0),
    (0x3f8010157589007e, -1.4902732911301337e-14),
    (0x3f9020565893807c, -3.527980389655325e-14),
    (0x3f98492528c9007a, -4.730054772033249e-14),
    (0x3fa0415d89e74078, 7.580310369375161e-15),
    (0x3fa466aed42e0076, -4.9893776716773285e-14),
    (0x3fa894aa149fc074, -2.262629393030674e-14),
    (0x3faccb73cdddc072, -2.345674491018699e-14),
    (0x3faeea31c006c071, -1.3352588834854848e-14),
    (0x3fb1973bd146606f, -3.765296820388875e-14),
    (0x3fb3bdf5a7d1e06d, 5.1128335719851986e-14),
    (0x3fb5e95a4d97a06b, -5.046674438470119e-14),
    (0x3fb700d30aeac06a, 3.1218748807418837e-15),
    (0x3fb9335e5d594068, 3.3871241029241416e-14),
    (0x3fbb6ac88dad6066, -1.7376727386423858e-14),
    (0x3fbc885801bc4065, 3.957125899799804e-14),
    (0x3fbec739830a2063, -5.2849453521890294e-14),
    (0x3fbfe89139dbe062, -3.767012502308738e-14),
    (0x3fc1178e8227e060, 3.1859736349078334e-14),
    (0x3fc1aa2b7e23f05f, 5.0900642926060466e-14),
    (0x3fc2d1610c86805d, 8.710783796122478e-15),
    (0x3fc365fcb015905c, 6.157896229122976e-16),
    (0x3fc4913d8333b05a, 3.821577743916796e-14),
    (0x3fc527e5e4a1b059, 3.9440046718453496e-14),
    (0x3fc6574ebe8c1057, 2.2924522154618074e-14),
    (0x3fc6f0128b757056, -3.742530094732263e-14),
    (0x3fc7898d85445055, -2.5223102140407338e-14),
    (0x3fc8beafeb390053, -1.0320443688698849e-14),
    (0x3fc95a5adcf70052, 1.0634128304268335e-14),
    (0x3fca93ed3c8ae050, -4.3425422595242564e-14),
    (0x3fcb31d8575bd04f, -1.2527395755711364e-14),
    (0x3fcbd087383be04e, -5.204008743405884e-14),
    (0x3fcc6ffbc6f0104d, -3.979844515951702e-15),
    (0x3fcdb13db0d4904b, -4.7955860343296286e-14),
    (0x3fce530effe7104a, 5.015686013791602e-16),
    (0x3fcef5ade4dd0049, -7.252318953240293e-16),
    (0x3fcf991c6cb3b048, 2.4688324156011588e-14),
    (0x3fd07138604d5846, 5.465121253624792e-15),
    (0x3fd0c42d67616045, 4.102651071698446e-14),
    (0x3fd1178e8227e844, -4.996736502345936e-14),
    (0x3fd16b5ccbacf843, 4.903580708156347e-14),
    (0x3fd1bf99635a6842, 5.089628039500759e-14),
    (0x3fd214456d0eb841, 1.1782016386565151e-14),
    (0x3fd2bef07cdc903f, 4.727452940514406e-14),
    (0x3fd314f1e1d3603e, -4.4204083338755686e-14),
    (0x3fd36b6776be103d, 1.548345993498083e-14),
    (0x3fd3c2527733303c, 2.1522127491642888e-14),
    (0x3fd419b423d5e83b, 1.1054030169005386e-14),
    (0x3fd4718dc271c83a, -5.534326352070679e-14),
    (0x3fd4c9e09e173039, -5.351646604259541e-14),
    (0x3fd522ae0738a038, 5.4612144489920215e-14),
    (0x3fd57bf753c8d037, 2.8136969901227338e-14),
    (0x3fd5d5bddf596036, -1.156568624616423e-14))

 @inline function log_tab_unpack(t::UInt64)
    invc = UInt64(t&UInt64(0xff)|0x1ff00)<<45
    logc = t&(~UInt64(0xff))
    return (reinterpret(Float64, invc), reinterpret(Float64, logc))
end

function evalpoly(x, p::Tuple)
    if @generated
        N = length(p.parameters::Core.SimpleVector)
        ex = :(p[end])
        for i in N-1:-1:1
            ex = :(muladd(x, $ex, p[$i]))
        end
        ex
    else
        _evalpoly(x, p)
    end
end

""" Splits a Float64 into a hi bit and a low bit where the high bit has 27 trailing 0s and the low bit has 26 trailing 0s"""
@inline function splitbits(x::Float64)
    hi = reinterpret(Float64, reinterpret(UInt64, x) & 0xffff_ffff_f800_0000)
    return hi, x-hi
end

@inline function two_mul(a::Float64, b::Float64)
    ahi, alo = splitbits(a)
    bhi, blo = splitbits(b)
    abhi = a*b
    blohi, blolo = splitbits(blo)
    ablo = alo*blohi - (((abhi - ahi*bhi) - alo*bhi) - ahi*blo) + blolo*alo
    return abhi, ablo
end

@inline function two_mul(a::T, b::T) where T<: Union{Float16, Float32}
    ab = widen(a)*b
    Tab = T(ab)
    Tab, T(ab-Tab)
end

# Log implementation that returns 2 numbers which sum to give true value with about 68 bits of precision
# Since `log` only makes sense for positive exponents, we speed up the implementation by stealing the sign bit
# of the input for an extra bit of the exponent which is used to normalize subnormal inputs.
# Does not normalize results.
# Adapted and modified from https://github.com/ARM-software/optimized-routines/blob/master/math/pow.c
# Copyright (c) 2018-2020, Arm Limited. (which is MIT licensed)
# note that this isn't an exact translation as this version compacts the table to reduce cache pressure.
function _log_ext(xu)
    # x = 2^k z; where z is in range [0x1.69555p-1,0x1.69555p-0) and exact.
    # The range is split into N subintervals.
    # The ith subinterval contains z and c is near the center of the interval.
    tmp = reinterpret(Int64, xu - 0x3fe6955500000000) #0x1.69555p-1
    i = (tmp >> 45) & 127
    z = reinterpret(Float64, xu - (tmp & 0xfff0000000000000))
    k = Float64(tmp >> 52)
    # log(x) = k*Ln2 + log(c) + log1p(z/c-1).
    # getfield instead of getindex to satisfy effect analysis not knowing whether this is inbounds
    t, logctail = getfield(t_log_table_compact, Int(i+1))
    invc, logc = log_tab_unpack(t)
    # Note: invc is j/N or j/N/2 where j is an integer in [N,2N) and
    # |z/c - 1| < 1/N, so r = z/c - 1 is exactly representable.
    r = fma(z, invc, -1.0)
    # k*Ln2 + log(c) + r.
    t1 = muladd(k, 0.6931471805598903, logc) #ln(2) hi part
    t2 = t1 + r
    lo1 = muladd(k, 5.497923018708371e-14, logctail) #ln(2) lo part
    lo2 = t1 - t2 + r
    ar = -0.5 * r
    ar2, lo3 = two_mul(r, ar)
    # k*Ln2 + log(c) + r + .5*r*r.
    hi = t2 + ar2
    lo4 = t2 - hi + ar2
    p = evalpoly(r, (-0x1.555555555556p-1, 0x1.0000000000006p-1, -0x1.999999959554ep-2, 0x1.555555529a47ap-2, -0x1.2495b9b4845e9p-2, 0x1.0002b8b263fc3p-2))
    lo = lo1 + lo2 + lo3 + muladd(r*ar2, p, lo4)
    return hi, lo
end
