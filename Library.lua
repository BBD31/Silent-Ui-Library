local Library = {}
Library.Tabs = {}

function Library:AddWindow(options)
    options = options or {}
    local title = options.Title or ""
    local size = options.Size or UDim2.new(0, 500, 0, 400)

    -- ScreenGui
    local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    gui.Name = "DarkUI_" .. tostring(math.random(1000, 9999))
    gui.ResetOnSpawn = false

    -- DragFrame
    local dragFrame = Instance.new("Frame", gui)
    dragFrame.Name = "MainFrame"
    dragFrame.Size = size
    dragFrame.Position = UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2)
    dragFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    dragFrame.BorderSizePixel = 0
    dragFrame.Active = true
    dragFrame.Draggable = true

    -- Title
    local titleLabel = Instance.new("TextLabel", dragFrame)
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 18
    titleLabel.BorderSizePixel = 0

    -- Main Content
    local content = Instance.new("Frame", dragFrame)
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 1, -30)
    content.Position = UDim2.new(0, 0, 0, 30)
    content.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout", content)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 4)

    Library.GUI = gui
    Library.Main = content
end

-- Додавання вкладок
function Library:AddTab(tabName)
    local tab = {}
    tab.Container = Instance.new("Frame", Library.Main)
    tab.Container.Size = UDim2.new(1, 0, 0, 0)
    tab.Container.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", tab.Container)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4)

    -- AddToggle
    function tab:AddToggle(opts)
        local toggle = Instance.new("TextButton", tab.Container)
        toggle.Size = UDim2.new(1, -10, 0, 30)
        toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        toggle.Text = opts.Text or "Toggle"
        toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggle.BorderSizePixel = 0

        local state = opts.Default or false
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(30, 30, 30)

        toggle.MouseButton1Click:Connect(function()
            state = not state
            toggle.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(30, 30, 30)
            if opts.Callback then opts.Callback(state) end
        end)
    end

    -- AddButton
    function tab:AddButton(opts)
        local btn = Instance.new("TextButton", tab.Container)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.Text = opts.Text or "Button"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.MouseButton1Click:Connect(function()
            if opts.Callback then opts.Callback() end
        end)
    end

    -- AddLabel
    function tab:AddLabel(opts)
        local lbl = Instance.new("TextLabel", tab.Container)
        lbl.Size = UDim2.new(1, -10, 0, 25)
        lbl.BackgroundTransparency = 1
        lbl.Text = opts.Text or "Label"
        lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end

    table.insert(Library.Tabs, tab)
    return tab
end

return Library
