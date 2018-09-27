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
{-
data Red    = Red
data RG     = RG
data RGB    = RGB
data RGBA   = RGBA
-}

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
{-
    ColorOp         :  (IsVecScalar d mask Bool, IsVecScalar d color c, IsNum c, IsScalar mask)
                    => Blending c   -- blending type
                    -> mask         -- write mask
                    -> FragmentOperation (Color color)
-}