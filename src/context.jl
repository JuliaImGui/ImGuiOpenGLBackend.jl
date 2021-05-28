"""
    mutable struct Context
A contextual data object that hosts OpenGL handles.
"""
Base.@kwdef mutable struct Context
    GlslVersion = 150
    FontTexture = GLuint(0)
    ShaderHandle = GLuint(0)
    VertHandle = GLuint(0)
    FragHandle = GLuint(0)
    AttribLocationTex = GLint(0)
    AttribLocationProjMtx = GLint(0)
    AttribLocationVtxPos = GLint(0)
    AttribLocationVtxUV = GLint(0)
    AttribLocationVtxColor = GLint(0)
    VboHandle = GLuint(0)
    ElementsHandle = GLuint(0)
    ImageTexture = Dict{Int,GLuint}()
end

"""
    create_context(glsl_version=150)
Return a OpenGL backend contextual data object.
"""
create_context(glsl_version=150) = Context(; GlslVersion=glsl_version)
