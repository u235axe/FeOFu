module Graphics


data Frequency
    = Obj
    | V
    | G
    | F

data OutputType
    = SingleOutput
    | MultiOutput

-- primitive types
data PrimitiveType
    = Triangle
    | Line
    | Point
    | TriangleAdjacency
    | LineAdjacency

data FetchPrimitive : PrimitiveType -> Type where
    Points                  : FetchPrimitive Point
    Lines                   : FetchPrimitive Line
    Triangles               : FetchPrimitive Triangle
    LinesAdjacency          : FetchPrimitive LineAdjacency
    TrianglesAdjacency      : FetchPrimitive TriangleAdjacency

data OutputPrimitive : PrimitiveType -> Type where
    TrianglesOutput : OutputPrimitive Triangle
    LinesOutput     : OutputPrimitive Line
    PointsOutput    : OutputPrimitive Point

data TextureShape
    = Tex1D
    | Tex2D
    | Tex3D
    | TexRect

data ColorArity
  = Red
  | RG
  | RGB
  | RGBA

data TextureSemantics a
    = Regular a
    | Shadow a
    | MultiSample a
    | Buffer a

data TextureArray
    = SingleTex     -- singleton texture
    | ArrayTex      -- array texture
    | CubeTex       -- cube texture = array with size 6

--data Sampler dim layerCount t ar
data Sampler : TextureShape -> TextureArray -> TextureSemantics Type -> Type -> Type

data V2 a = MkV2 a
data V3 a = MkV3 a
data V4 a = MkV4 a

data Float  = MkFloat
data Int32  = MkInt32
data Word32 = MkWord32
data Word = MkWord

V2F : Type
V2F = V2 Float
V3F : Type
V3F = V3 Float
V4F : Type
V4F = V4 Float

V2I : Type
V2I = V2 Int32
V3I : Type
V3I = V3 Int32
V4I : Type
V4I = V4 Int32

V2U : Type
V2U = V2 Word32
V3U : Type
V3U = V3 Word32
V4U : Type
V4U = V4 Word32

V2B : Type
V2B = V2 Bool
V3B : Type
V3B = V3 Bool
V4B : Type
V4B = V4 Bool

-- matrices are stored in column major order
M22F : Type
M22F = V2 V2F
M23F : Type
M23F = V3 V2F
M24F : Type
M24F = V4 V2F
M32F : Type
M32F = V2 V3F
M33F : Type
M33F = V3 V3F
M34F : Type
M34F = V4 V3F
M42F : Type
M42F = V2 V4F
M43F : Type
M43F = V3 V4F
M44F : Type
M44F = V4 V4F

data PointSpriteCoordOrigin = LowerLeft | UpperLeft
data PointSize              = ConstPointSize Float | ProgramPointSize
data ProvokingVertex        = FirstVertex | LastVertex
data FrontFace              = CCW | CW
data CullMode               = CullNone | CullFront FrontFace | CullBack FrontFace
data PolygonMode            = PolygonPoint PointSize | PolygonLine Float | PolygonFill
data PolygonOffset          = NoOffset | Offset Float Float

-- raster context description
data RasterContext : PrimitiveType -> Type where
    PointCtx :
        ( ctxPointSize          : PointSize) ->
        ( ctxFadeThresholdSize  : Float) ->
        ( ctxSpriteCoordOrigin  : PointSpriteCoordOrigin) ->
        RasterContext Point

    LineCtx :
        ( ctxLineWidth          : Float) ->
        ( ctxProvokingVertex'   : ProvokingVertex) ->
        RasterContext Line

    TriangleCtx :
        ( ctxCullMode           : CullMode) ->
        ( ctxPolygonMode        : PolygonMode) ->
        ( ctxPolygonOffset      : PolygonOffset) ->
        ( ctxProvokingVertex    : ProvokingVertex) ->
        RasterContext Triangle

-- framebuffer data / fragment output semantic
data Color a
data Depth a
data Stencil a

data ComparisonFunction     = Never | Less | Equal | Lequal | Greater | Notequal | Gequal | Always

DepthFunction : Type
DepthFunction = ComparisonFunction

record StencilTest where
    constructor MkStencilTest
    stencilComparision    : ComparisonFunction   -- ^ The function used to compare the @stencilReference@ and the stencil buffers value with.
    stencilReference      : Int32                -- ^ The value to compare with the stencil buffer's value.
    stencilMask           : Word32               -- ^ A bit mask with ones in each position that should be compared and written to the stencil buffer.

data StencilTests = MkStencilTests StencilTest StencilTest

data StencilOperation = OpZero | OpKeep | OpReplace | OpIncr | OpIncrWrap | OpDecr | OpDecrWrap | OpInvert

record StencilOps where
    constructor MkStencilOps
    frontStencilOp    : StencilOperation -- ^ Used for front faced triangles and other primitives.
    backStencilOp     : StencilOperation -- ^ Used for back faced triangles.

data LogicOperation
  = Clear | And | AndReverse | Copy | AndInverted | Noop | Xor | Or | Nor | Equiv | Invert | OrReverse | CopyInverted | OrInverted | Nand | Set

interface IsIntegral a where
IsIntegral Int32 where
IsIntegral Word32 where

interface IsScalar a where
IsScalar Int32 where
IsScalar Word32 where
IsScalar Float where
IsScalar Bool where
IsScalar M22F where
IsScalar M23F where
IsScalar M24F where
IsScalar M32F where
IsScalar M33F where
IsScalar M34F where
IsScalar M42F where
IsScalar M43F where
IsScalar M44F where
IsScalar V2F where
IsScalar V3F where
IsScalar V4F where
IsScalar V2I where
IsScalar V3I where
IsScalar V4I where
IsScalar V2U where
IsScalar V3U where
IsScalar V4U where
IsScalar V2B where
IsScalar V3B where
IsScalar V4B where

interface IsNum a where
IsNum Float where
IsNum Int32 where
IsNum Word32 where

interface IsSigned a where
IsSigned Float where
IsSigned Int where

-- vector types: V2, V3, V4
interface IsVec (dim : Nat) vec component where
IsVec 2 (V2 Float) Float where
IsVec 3 (V3 Float) Float where
IsVec 4 (V4 Float) Float where
IsVec 2 (V2 Int32) Int32 where
IsVec 3 (V3 Int32) Int32 where
IsVec 4 (V4 Int32) Int32 where
IsVec 2 (V2 Word32) Word32 where
IsVec 3 (V3 Word32) Word32 where
IsVec 4 (V4 Word32) Word32 where
IsVec 2 (V2 Bool) Bool where
IsVec 3 (V3 Bool) Bool where
IsVec 4 (V4 Bool) Bool where

-- scalar and vector types: scalar, V2, V3, V4
interface IsVecScalar (dim : Nat) vec component where
IsVecScalar 1 Float Float where
IsVecScalar 2 (V2 Float) Float where
IsVecScalar 3 (V3 Float) Float where
IsVecScalar 4 (V4 Float) Float where
IsVecScalar 1 Int32 Int32 where
IsVecScalar 2 (V2 Int32) Int32 where
IsVecScalar 3 (V3 Int32) Int32 where
IsVecScalar 4 (V4 Int32) Int32 where
IsVecScalar 1 Word32 Word32 where
IsVecScalar 2 (V2 Word32) Word32 where
IsVecScalar 3 (V3 Word32) Word32 where
IsVecScalar 4 (V4 Word32) Word32 where
IsVecScalar 1 Bool Bool where
IsVecScalar 2 (V2 Bool) Bool where
IsVecScalar 3 (V3 Bool) Bool where
IsVecScalar 4 (V4 Bool) Bool where

interface IsMat mat h w where
IsMat M22F V2F V2F where
IsMat M23F V2F V3F where
IsMat M24F V2F V4F where
IsMat M32F V3F V2F where
IsMat M33F V3F V3F where
IsMat M34F V3F V4F where
IsMat M42F V4F V2F where
IsMat M43F V4F V3F where
IsMat M44F V4F V4F where

-- matrix, vector and scalar types
interface IsMatVecScalar a t where
IsMatVecScalar Float Float  where
IsMatVecScalar (V2 Float) Float where
IsMatVecScalar (V3 Float) Float where
IsMatVecScalar (V4 Float) Float where
IsMatVecScalar Int32 Int32 where
IsMatVecScalar (V2 Int32) Int32 where
IsMatVecScalar (V3 Int32) Int32 where
IsMatVecScalar (V4 Int32) Int32 where
IsMatVecScalar Word32 Word32 where
IsMatVecScalar (V2 Word32) Word32 where
IsMatVecScalar (V3 Word32) Word32 where
IsMatVecScalar (V4 Word32) Word32 where
IsMatVecScalar Bool Bool where
IsMatVecScalar (V2 Bool) Bool where
IsMatVecScalar (V3 Bool) Bool where
IsMatVecScalar (V4 Bool) Bool where
IsMatVecScalar M22F Float where
IsMatVecScalar M23F Float where
IsMatVecScalar M24F Float where
IsMatVecScalar M32F Float where
IsMatVecScalar M33F Float where
IsMatVecScalar M34F Float where
IsMatVecScalar M42F Float where
IsMatVecScalar M43F Float where
IsMatVecScalar M44F Float where

-- matrix and vector types
interface IsMatVec a t where
IsMatVec (V2 Float) Float where
IsMatVec (V3 Float) Float where
IsMatVec (V4 Float) Float where
IsMatVec (V2 Int32) Int32 where
IsMatVec (V3 Int32) Int32 where
IsMatVec (V4 Int32) Int32 where
IsMatVec (V2 Word32) Word32 where
IsMatVec (V3 Word32) Word32 where
IsMatVec (V4 Word32) Word32 where
IsMatVec (V2 Bool) Bool where
IsMatVec (V3 Bool) Bool where
IsMatVec (V4 Bool) Bool where
IsMatVec M22F Float where
IsMatVec M23F Float where
IsMatVec M24F Float where
IsMatVec M32F Float where
IsMatVec M33F Float where
IsMatVec M34F Float where
IsMatVec M42F Float where
IsMatVec M43F Float where
IsMatVec M44F Float where

-- matrix or vector component type
interface IsComponent a where
IsComponent Float where
IsComponent Int32 where
IsComponent Word32 where
IsComponent Bool where
IsComponent V2F where
IsComponent V3F where
IsComponent V4F where

data BlendEquation  = FuncAdd | FuncSubtract | FuncReverseSubtract | Min | Max
data BlendingFactor = Zero | One | SrcColor | OneMinusSrcColor | DstColor | OneMinusDstColor | SrcAlpha | OneMinusSrcAlpha | DstAlpha | OneMinusDstAlpha
                    | ConstantColor | OneMinusConstantColor | ConstantAlpha | OneMinusConstantAlpha | SrcAlphaSaturate

data Blending : (t : Type) -> Type where
    NoBlending      : Blending t

    BlendLogicOp    :  IsIntegral t
                    => LogicOperation
                    -> Blending t

    -- FIXME: restrict BlendingFactor at some BlendEquation
    Blend           :  (BlendEquation, BlendEquation) 
                    -> ((BlendingFactor, BlendingFactor), (BlendingFactor, BlendingFactor))
                    -> V4F
                    -> Blending Float

b1 : Blending Int32
b1 = BlendLogicOp Clear

-- Fragment Operation
data FragmentOperation : Type -> Type where
    DepthOp         :  DepthFunction
                    -> Bool     -- depth write
                    -> FragmentOperation (Depth Float)

    StencilOp       :  StencilTests
                    -> StencilOps
                    -> StencilOps
                    -> FragmentOperation (Stencil Int32)

    ColorOp         :  (IsVecScalar d mask Bool, IsVecScalar d color c, IsNum c, IsScalar mask)
                    => Blending c   -- blending type
                    -> mask         -- write mask
                    -> FragmentOperation (Color color)

-- specifies an empty image (pixel rectangle)
-- hint: framebuffer is composed from images
data Image : (layerCount : Nat) -> Type -> Type where
    DepthImage      :  (layerCount : Nat)
                    -> Float    -- initial value
                    -> Image layerCount (Depth Float)

    StencilImage    :  (layerCount : Nat)
                    -> Int32    -- initial value
                    -> Image layerCount (Stencil Int32)

    ColorImage      :  (IsNum t, IsVecScalar d color t, IsScalar color)
                    => (layerCount : Nat)
                    -> color    -- initial value
                    -> Image layerCount (Color color)

    UnclearedImage  :  (IsNum t, IsVecScalar d color t, IsScalar color)
                    => (layerCount : Nat)
                    -> Image layerCount (Color color)

-- sampler and texture specification
data TextureMipMap
    = TexMip
    | TexNoMip

data MipMap : TextureMipMap -> Type where
    NoMip   :  MipMap TexNoMip

    Mip     :  Int  -- base level
            -> Int  -- max level
            -> MipMap TexMip

    AutoMip :  Int  -- base level
            -> Int  -- max level
            -> MipMap TexMip

-- describes texel (texture component) type
data TextureDataType : TextureSemantics c -> ColorArity -> Type where
    FloatTx   :  (a : ColorArity)
              -> TextureDataType (Regular Float) a

    IntTx     :  (a : ColorArity)
              -> TextureDataType (Regular Int) a

    WordTx    :  (a : ColorArity)
              -> TextureDataType (Regular Word) a

    ShadowTx  :  TextureDataType (Shadow Float) Red   -- TODO: add params required by shadow textures

TexArrRepr : Nat -> TextureArray
TexArrRepr layerCount = if layerCount > 1 then ArrayTex else SingleTex

-- fully describes a texture type
data TextureType : TextureShape -> TextureMipMap -> TextureArray -> Nat -> TextureSemantics c -> ColorArity -> Type where -- hint: arr - single or array texture, ar - arity (Red,RG,RGB,..)
    Texture1D       :  TextureDataType t ar
                    -> (layerCount : Nat)
                    -> TextureType Tex1D TexMip (TexArrRepr layerCount) layerCount t ar

    Texture2D       :  TextureDataType t ar
                    -> (layerCount : Nat)
                    -> TextureType Tex2D TexMip (TexArrRepr layerCount) layerCount t ar

    Texture3D       :  TextureDataType (Regular t) ar
                    -> TextureType Tex3D TexMip SingleTex 1 (Regular t) ar

    TextureCube     :  TextureDataType t ar
                    -> TextureType Tex2D TexMip CubeTex 6 t ar

    TextureRect     :  TextureDataType t ar
                    -> TextureType TexRect TexNoMip SingleTex 1 t ar

    Texture2DMS     :  TextureDataType (Regular t) ar
                    -> (layerCount : Nat)
                    -> TextureType Tex2D TexNoMip (TexArrRepr layerCount) layerCount (MultiSample t) ar

    TextureBuffer   :  TextureDataType (Regular t) ar
                    -> TextureType Tex1D TexNoMip SingleTex 1 (Buffer t) ar

data PrimFun : Frequency -> Type -> Type where
{-
    -- Vec/Mat (de)construction
    PrimTupToV2             : IsComponent a                            => PrimFun stage ((a,a)     -> V2 a)
    PrimTupToV3             : IsComponent a                            => PrimFun stage ((a,a,a)   -> V3 a)
    PrimTupToV4             : IsComponent a                            => PrimFun stage ((a,a,a,a) -> V4 a)
    PrimV2ToTup             : IsComponent a                            => PrimFun stage (V2 a     -> (a,a))
    PrimV3ToTup             : IsComponent a                            => PrimFun stage (V3 a   -> (a,a,a))
    PrimV4ToTup             : IsComponent a                            => PrimFun stage (V4 a -> (a,a,a,a))
-}
    -- Arithmetic Functions (componentwise)
    PrimAdd                 : (IsNum t, IsMatVec a t)                              => PrimFun stage ((a,a)   -> a)
    PrimAddS                : (IsNum t, IsMatVecScalar a t)                        => PrimFun stage ((a,t)   -> a)
    PrimSub                 : (IsNum t, IsMatVec a t)                              => PrimFun stage ((a,a)   -> a)
    PrimSubS                : (IsNum t, IsMatVecScalar a t)                        => PrimFun stage ((a,t)   -> a)
    PrimMul                 : (IsNum t, IsMatVec a t)                              => PrimFun stage ((a,a)   -> a)
    PrimMulS                : (IsNum t, IsMatVecScalar a t)                        => PrimFun stage ((a,t)   -> a)
    PrimDiv                 : (IsNum t, IsVecScalar d a t)                         => PrimFun stage ((a,a)   -> a)
    PrimDivS                : (IsNum t, IsVecScalar d a t)                         => PrimFun stage ((a,t)   -> a)
    PrimNeg                 : (IsSigned t, IsMatVecScalar a t)                     => PrimFun stage (a       -> a)
    PrimMod                 : (IsNum t, IsVecScalar d a t)                         => PrimFun stage ((a,a)   -> a)
    PrimModS                : (IsNum t, IsVecScalar d a t)                         => PrimFun stage ((a,t)   -> a)

    -- Bit-wise Functions
    PrimBAnd        : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a,a)   -> a)
    PrimBAndS       : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a,t)   -> a)
    PrimBOr         : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a,a)   -> a)
    PrimBOrS        : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a,t)   -> a)
    PrimBXor        : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a,a)   -> a)
    PrimBXorS       : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a,t)   -> a)
    PrimBNot        : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage (a       -> a)
    PrimBShiftL     : (IsIntegral t, IsVecScalar d a t, IsVecScalar d b Word32)    => PrimFun stage ((a, b)      -> a)
    PrimBShiftLS    : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a, Word32) -> a)
    PrimBShiftR     : (IsIntegral t, IsVecScalar d a t, IsVecScalar d b Word32)    => PrimFun stage ((a, b)      -> a)
    PrimBShiftRS    : (IsIntegral t, IsVecScalar d a t)                            => PrimFun stage ((a, Word32) -> a)

    -- Logic Functions
    PrimAnd                 :                                             PrimFun stage ((Bool,Bool) -> Bool)
    PrimOr                  :                                             PrimFun stage ((Bool,Bool) -> Bool)
    PrimXor                 :                                             PrimFun stage ((Bool,Bool) -> Bool)
    PrimNot                 : IsVecScalar d a Bool                           => PrimFun stage (a           -> a)
    PrimAny                 : IsVecScalar d a Bool                           => PrimFun stage (a           -> Bool)
    PrimAll                 : IsVecScalar d a Bool                           => PrimFun stage (a           -> Bool)

    -- Angle and Trigonometry Functions
    PrimACos                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimACosH               : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimASin                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimASinH               : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimATan                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimATan2               : IsVecScalar d a Float                          => PrimFun stage ((a,a) -> a)
    PrimATanH               : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimCos                 : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimCosH                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimDegrees             : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimRadians             : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimSin                 : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimSinH                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimTan                 : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimTanH                : IsVecScalar d a Float                          => PrimFun stage (a -> a)

    -- Exponential Functions
    PrimPow                 : IsVecScalar d a Float                          => PrimFun stage ((a,a) -> a)
    PrimExp                 : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimLog                 : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimExp2                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimLog2                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimSqrt                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimInvSqrt             : IsVecScalar d a Float                          => PrimFun stage (a -> a)

    -- Common Functions
    PrimIsNan               : (IsVecScalar d a Float, IsVecScalar d b Bool)        => PrimFun stage (a -> b)
    PrimIsInf               : (IsVecScalar d a Float, IsVecScalar d b Bool)        => PrimFun stage (a -> b)
    PrimAbs                 : (IsSigned t, IsVecScalar d a t)                => PrimFun stage (a -> a)
    PrimSign                : (IsSigned t, IsVecScalar d a t)                => PrimFun stage (a -> a)
    PrimFloor               : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimTrunc               : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimRound               : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimRoundEven           : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimCeil                : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimFract               : IsVecScalar d a Float                          => PrimFun stage (a -> a)
    PrimModF                : IsVecScalar d a Float                          => PrimFun stage (a               -> (a,a))
    PrimMin                 : (IsNum t, IsVecScalar d a t)                   => PrimFun stage ((a,a)           -> a)
    PrimMinS                : (IsNum t, IsVecScalar d a t)                   => PrimFun stage ((a,t)           -> a)
    PrimMax                 : (IsNum t, IsVecScalar d a t)                   => PrimFun stage ((a,a)           -> a)
    PrimMaxS                : (IsNum t, IsVecScalar d a t)                   => PrimFun stage ((a,t)           -> a)
    PrimClamp               : (IsNum t, IsVecScalar d a t)                   => PrimFun stage ((a,a,a)         -> a)
    PrimClampS              : (IsNum t, IsVecScalar d a t)                   => PrimFun stage ((a,t,t)         -> a)
    PrimMix                 : IsVecScalar d a Float                          => PrimFun stage ((a,a,a)         -> a)
    PrimMixS                : IsVecScalar d a Float                          => PrimFun stage ((a,a,Float)     -> a)
    PrimMixB                : (IsVecScalar d a Float, IsVecScalar d b Bool)        => PrimFun stage ((a,a,b)         -> a)
    PrimStep                : IsVec d a Float                                => PrimFun stage ((a,a)           -> a)
    PrimStepS               : IsVecScalar d a Float                          => PrimFun stage ((Float,a)       -> a)
    PrimSmoothStep          : IsVec d a Float                                => PrimFun stage ((a,a,a)         -> a)
    PrimSmoothStepS         : IsVecScalar d a Float                          => PrimFun stage ((Float,Float,a) -> a)

    -- Integer/Float Conversion Functions
    PrimFloatBitsToInt      : (IsVecScalar d fv Float, IsVecScalar d iv Int32)     => PrimFun stage (fv -> iv)
    PrimFloatBitsToUInt     : (IsVecScalar d fv Float, IsVecScalar d uv Word32)    => PrimFun stage (fv -> uv)
    PrimIntBitsToFloat      : (IsVecScalar d fv Float, IsVecScalar d iv Int32)     => PrimFun stage (iv -> fv)
    PrimUIntBitsToFloat     : (IsVecScalar d fv Float, IsVecScalar d uv Word32)    => PrimFun stage (uv -> fv)

    -- Geometric Functions
    PrimLength              : IsVecScalar d a Float                          => PrimFun stage (a       -> Float)
    PrimDistance            : IsVecScalar d a Float                          => PrimFun stage ((a,a)   -> Float)
    PrimDot                 : IsVecScalar d a Float                          => PrimFun stage ((a,a)   -> Float)
    PrimCross               : IsVecScalar 3 a Float                          => PrimFun stage ((a,a)   -> a)
    PrimNormalize           : IsVecScalar d a Float                          => PrimFun stage (a       -> a)
    PrimFaceForward         : IsVecScalar d a Float                          => PrimFun stage ((a,a,a) -> a)
    PrimReflect             : IsVecScalar d a Float                          => PrimFun stage ((a,a)   -> a)
    PrimRefract             : IsVecScalar d a Float                          => PrimFun stage ((a,a,a) -> a)

    -- Matrix Functions
    PrimTranspose           : (IsMat a h w, IsMat b w h)               => PrimFun stage (a       -> b)
    PrimDeterminant         : IsMat m s s                              => PrimFun stage (m       -> Float)
    PrimInverse             : IsMat m h w                              => PrimFun stage (m       -> m)
    PrimOuterProduct        : IsMat m h w                              => PrimFun stage ((w,h)   -> m)
    PrimMulMatVec           : IsMat m h w                              => PrimFun stage ((m,w)   -> h)
    PrimMulVecMat           : IsMat m h w                              => PrimFun stage ((h,m)   -> w)
    PrimMulMatMat           : (IsMat a i j, IsMat b j k, IsMat c i k)  => PrimFun stage ((a,b)   -> c)

    -- Vector and Scalar Relational Functions
    PrimLessThan            : (IsNum t, IsVecScalar d a t, IsVecScalar d b Bool)   => PrimFun stage ((a,a) -> b)
    PrimLessThanEqual       : (IsNum t, IsVecScalar d a t, IsVecScalar d b Bool)   => PrimFun stage ((a,a) -> b)
    PrimGreaterThan         : (IsNum t, IsVecScalar d a t, IsVecScalar d b Bool)   => PrimFun stage ((a,a) -> b)
    PrimGreaterThanEqual    : (IsNum t, IsVecScalar d a t, IsVecScalar d b Bool)   => PrimFun stage ((a,a) -> b)
    PrimEqualV              : (IsNum t, IsVecScalar d a t, IsVecScalar d b Bool)   => PrimFun stage ((a,a) -> b)
    PrimEqual               : IsMatVecScalar a t                                   => PrimFun stage ((a,a) -> Bool)
    PrimNotEqualV           : (IsNum t, IsVecScalar d a t, IsVecScalar d b Bool)   => PrimFun stage ((a,a) -> b)
    PrimNotEqual            : IsMatVecScalar a t                                   => PrimFun stage ((a,a) -> Bool)

    -- Fragment Processing Functions
    PrimDFdx                : IsVecScalar d a Float                          => PrimFun F (a -> a)
    PrimDFdy                : IsVecScalar d a Float                          => PrimFun F (a -> a)
    PrimFWidth              : IsVecScalar d a Float                          => PrimFun F (a -> a)

    -- Noise Functions
    PrimNoise1              : IsVecScalar d a Float                             => PrimFun stage (a -> Float)
    PrimNoise2              : (IsVecScalar d a Float, IsVecScalar 2 b Float)    => PrimFun stage (a -> b)
    PrimNoise3              : (IsVecScalar d a Float, IsVecScalar 3 b Float)    => PrimFun stage (a -> b)
    PrimNoise4              : (IsVecScalar d a Float, IsVecScalar 4 b Float)    => PrimFun stage (a -> b)
{-
    -- Texture Lookup Functions
    PrimTextureSize             : IsTextureSize sampler lod size                           => PrimFun stage ((sampler,lod)                       -> size)
    PrimTexture                 : IsTexture sampler coord bias                             => PrimFun stage ((sampler,coord)                     -> TexelRepr sampler)
    PrimTextureB                : IsTexture sampler coord bias                             => PrimFun F     ((sampler,coord,bias)                -> TexelRepr sampler)
    PrimTextureProj             : IsTextureProj sampler coord bias                         => PrimFun stage ((sampler,coord)                     -> TexelRepr sampler)
    PrimTextureProjB            : IsTextureProj sampler coord bias                         => PrimFun F     ((sampler,coord,bias)                -> TexelRepr sampler)
    PrimTextureLod              : IsTextureLod sampler coord lod                           => PrimFun stage ((sampler,coord,lod)                 -> TexelRepr sampler)
    PrimTextureOffset           : IsTextureOffset sampler coord offset bias                => PrimFun stage ((sampler,coord,offset)              -> TexelRepr sampler)
    PrimTextureOffsetB          : IsTextureOffset sampler coord offset bias                => PrimFun F     ((sampler,coord,offset,bias)         -> TexelRepr sampler)
    PrimTexelFetch              : IsTexelFetch sampler coord lod                           => PrimFun stage ((sampler,coord,lod)                 -> TexelRepr sampler)
    PrimTexelFetchOffset        : IsTexelFetchOffset sampler coord lod offset              => PrimFun stage ((sampler,coord,lod,offset)          -> TexelRepr sampler)
    PrimTextureProjOffset       : IsTextureProjOffset sampler coord offset bias            => PrimFun stage ((sampler,coord,offset)              -> TexelRepr sampler)
    PrimTextureProjOffsetB      : IsTextureProjOffset sampler coord offset bias            => PrimFun F     ((sampler,coord,offset,bias)         -> TexelRepr sampler)
    PrimTextureLodOffset        : IsTextureLodOffset sampler coord lod offset              => PrimFun stage ((sampler,coord,lod,offset)          -> TexelRepr sampler)
    PrimTextureProjLod          : IsTextureProjLod sampler coord lod                       => PrimFun stage ((sampler,coord,lod)                 -> TexelRepr sampler)
    PrimTextureProjLodOffset    : IsTextureProjLodOffset sampler coord lod offset          => PrimFun stage ((sampler,coord,lod,offset)          -> TexelRepr sampler)
    PrimTextureGrad             : IsTextureGrad sampler coord dx dy                        => PrimFun stage ((sampler,coord,dx,dy)               -> TexelRepr sampler)
    PrimTextureGradOffset       : IsTextureGradOffset sampler coord dx dy offset           => PrimFun stage ((sampler,coord,dx,dy,offset)        -> TexelRepr sampler)
    PrimTextureProjGrad         : IsTextureProjGrad sampler coord dx dy                    => PrimFun stage ((sampler,coord,dx,dy)               -> TexelRepr sampler)
    PrimTextureProjGradOffset   : IsTextureProjGradOffset sampler coord dx dy offset       => PrimFun stage ((sampler,coord,dx,dy,offset)        -> TexelRepr sampler)
-}
