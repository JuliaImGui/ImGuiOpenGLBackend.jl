function ImGui_ImplOpenGL3_RenderWindow(viewport::Ptr{ImGuiViewport}, gl_ctx_ptr::Ptr{Cvoid})::Cvoid
    if !(unsafe_load(viewport.Flags) & ImGuiViewportFlags_NoRendererClear == ImGuiViewportFlags_NoRendererClear)
        glClearColor(0.0f0, 0.0f0, 0.0f0, 1.0f0)
        glClear(GL_COLOR_BUFFER_BIT)
    end
    # TODO: submit this to upstream
    dpi_scale = unsafe_load(viewport.DpiScale)
    draw_data = unsafe_load(viewport.DrawData)
    if unsafe_load(draw_data.FramebufferScale.x) != dpi_scale
        draw_data.FramebufferScale.x = dpi_scale
        draw_data.FramebufferScale.y = dpi_scale
    end
    ImGui_ImplOpenGL3_RenderDrawData(unsafe_pointer_to_objref(gl_ctx_ptr), draw_data)
    return nothing
end

function ImGui_ImplOpenGL3_InitPlatformInterface()
    platform_io::Ptr{ImGuiPlatformIO} = igGetPlatformIO()
    platform_io.Renderer_RenderWindow = @cfunction(ImGui_ImplOpenGL3_RenderWindow, Cvoid, (Ptr{ImGuiViewport}, Ptr{Cvoid}))
    return true
end

ImGui_ImplOpenGL3_ShutdownPlatformInterface() = igDestroyPlatformWindows()
