local Library = {} Library.__index = Library

function Library:CreateWindow(title) local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui")) ScreenGui.Name = title or "UniversalUILib"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(0, 120, 215)
UIStroke.Thickness = 1

local TabHolder = Instance.new("Frame", MainFrame)
TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabHolder.Size = UDim2.new(0, 110, 1, 0)
TabHolder.BorderSizePixel = 0

local TabList = Instance.new("UIListLayout", TabHolder)
TabList.SortOrder = Enum.SortOrder.LayoutOrder

local ContentHolder = Instance.new("Frame", MainFrame)
ContentHolder.Position = UDim2.new(0, 115, 0, 0)
ContentHolder.Size = UDim2.new(1, -115, 1, 0)
ContentHolder.BackgroundTransparency = 1

local Tabs = {}

function Tabs:AddTab(tabName)
    local Button = Instance.new("TextButton", TabHolder)
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Text = tabName
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 0

    local TabContent = Instance.new("ScrollingFrame", ContentHolder)
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = false

    local Layout = Instance.new("UIListLayout", TabContent)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 4)

    Button.MouseButton1Click:Connect(function()
        for _, v in pairs(ContentHolder:GetChildren()) do
            if v:IsA("ScrollingFrame") then
                v.Visible = false
            end
        end
        TabContent.Visible = true
    end)

    local Elements = {}

    function Elements:AddLabel(text)
        local Label = Instance.new("TextLabel", TabContent)
        Label.Size = UDim2.new(1, -10, 0, 25)
        Label.Text = text
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Label.BorderSizePixel = 0
    end

    function Elements:AddButton(text, callback)
        local Button = Instance.new("TextButton", TabContent)
        Button.Size = UDim2.new(1, -10, 0, 30)
        Button.Text = text
        Button.TextColor3 = Color3.new(1, 1, 1)
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Button.BorderSizePixel = 0
        Button.MouseButton1Click:Connect(callback)
    end

    function Elements:AddToggle(text, callback)
        local Toggle = Instance.new("TextButton", TabContent)
        Toggle.Size = UDim2.new(1, -10, 0, 30)
        Toggle.Text = text .. ": OFF"
        Toggle.TextColor3 = Color3.new(1, 1, 1)
        Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Toggle.BorderSizePixel = 0

        local state = false
        Toggle.MouseButton1Click:Connect(function()
            state = not state
            Toggle.Text = text .. (state and ": ON" or ": OFF")
            callback(state)
        end)
    end

    function Elements:AddSlider(text, min, max, callback)
        local Label = Instance.new("TextLabel", TabContent)
        Label.Size = UDim2.new(1, -10, 0, 25)
        Label.Text = text .. ": " .. tostring(min)
        Label.TextColor3 = Color3.new(1, 1, 1)
        Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Label.BorderSizePixel = 0

        local Slider = Instance.new("TextButton", TabContent)
        Slider.Size = UDim2.new(1, -10, 0, 25)
        Slider.Text = "[ Slide ]"
        Slider.TextColor3 = Color3.new(1, 1, 1)
        Slider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Slider.BorderSizePixel = 0

        Slider.MouseButton1Click:Connect(function()
            local value = math.random(min, max)
            Label.Text = text .. ": " .. tostring(value)
            callback(value)
        end)
    end

    function Elements:AddDropdown(text, options, callback)
        local Dropdown = Instance.new("TextButton", TabContent)
        Dropdown.Size = UDim2.new(1, -10, 0, 30)
        Dropdown.Text = text .. " ▼"
        Dropdown.TextColor3 = Color3.new(1, 1, 1)
        Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Dropdown.BorderSizePixel = 0

        local Opened = false
        local function ToggleDropdown()
            if Opened then return end
            Opened = true
            for _, option in pairs(options) do
                local OptBtn = Instance.new("TextButton", TabContent)
                OptBtn.Size = UDim2.new(1, -10, 0, 25)
                OptBtn.Text = option
                OptBtn.TextColor3 = Color3.new(1, 1, 1)
                OptBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                OptBtn.BorderSizePixel = 0

                OptBtn.MouseButton1Click:Connect(function()
                    callback(option)
                    OptBtn.Parent = nil
                    Opened = false
                end)
            end
        end

        Dropdown.MouseButton1Click:Connect(ToggleDropdown)
    end

    function Elements:AddColorPicker(text, default, callback)
        local Picker = Instance.new("TextButton", TabContent)
        Picker.Size = UDim2.new(1, -10, 0, 30)
        Picker.Text = text
        Picker.TextColor3 = default or Color3.new(1, 1, 1)
        Picker.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Picker.BorderSizePixel = 0

        Picker.MouseButton1Click:Connect(function()
            local newColor = Color3.fromRGB(math.random(255), math.random(255), math.random(255))
            Picker.TextColor3 = newColor
            callback(newColor)
        end)
    end

    TabContent.Visible = #ContentHolder:GetChildren() == 1
    return Elements
end

return Tabs

end

return setmetatable({}, Library)
