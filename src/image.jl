const g_ImageTexture = Dict{Int,GLuint}()

function ImGui_ImplOpenGL3_CreateImageTexture(image_width, image_height; format=GL_RGBA, type=GL_UNSIGNED_BYTE)
    id = GLuint(0)
    @c glGenTextures(1, &id)
    glBindTexture(GL_TEXTURE_2D, id)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glPixelStorei(GL_UNPACK_ROW_LENGTH, 0)
    glTexImage2D(GL_TEXTURE_2D, 0, format, GLsizei(image_width), GLsizei(image_height), 0, format, type, C_NULL)
    g_ImageTexture[id] = id
    return Int(id)
end

function ImGui_ImplOpenGL3_UpdateImageTexture(id, image_data, image_width, image_height; format=GL_RGBA, type=GL_UNSIGNED_BYTE)
    glBindTexture(GL_TEXTURE_2D, g_ImageTexture[id])
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, GLsizei(image_width), GLsizei(image_height), format, type, image_data)
end

function ImGui_ImplOpenGL3_DestroyImageTexture(id)
    id = g_ImageTexture[id]
    @c glDeleteTextures(1, &id)
    delete!(g_ImageTexture, id)
    return true
end

function ImGui_ImplOpenGL3_DestroyImages(ctx::Context)
    for (k,v) in ctx.ImageTexture
        ImGui_ImplOpenGL3_DestroyImageTexture(v)
    end
    return true
end
