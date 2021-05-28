function ImGui_ImplOpenGL3_RenderWindow(viewport::Ptr{ImGuiViewport}, gl_ctx_ptr::Ptr{Cvoid})::Cvoid
    vp = unsafe_load(viewport)
    if !(vp.Flags & ImGuiViewportFlags_NoRendererClear == ImGuiViewportFlags_NoRendererClear)
        glClearColor(0.0f0, 0.0f0, 0.0f0, 1.0f0)
        glClear(GL_COLOR_BUFFER_BIT)
    end
    ImGui_ImplOpenGL3_RenderDrawData(unsafe_pointer_to_objref(gl_ctx_ptr), vp.DrawData)
    return nothing
end

function ImGui_ImplOpenGL3_InitPlatformInterface()
    platform_io::Ptr{ImGuiPlatformIO} = igGetPlatformIO()
    platform_io.Renderer_RenderWindow = @cfunction(ImGui_ImplOpenGL3_RenderWindow, Cvoid, (Ptr{ImGuiViewport}, Ptr{Cvoid}))
    return true
end

ImGui_ImplOpenGL3_ShutdownPlatformInterface() = igDestroyPlatformWindows()
