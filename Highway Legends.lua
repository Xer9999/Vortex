-- Clean Mobile UI - Complete Fixed Version WITH VEHICLE TELEPORT
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Colors
local colors = {
    bg = Color3.fromRGB(15, 15, 20),
    surface = Color3.fromRGB(25, 25, 35),
    primary = Color3.fromRGB(0, 140, 255),
    primaryDark = Color3.fromRGB(0, 100, 200),
    text = Color3.fromRGB(255, 255, 255),
    text2 = Color3.fromRGB(160, 160, 180),
    success = Color3.fromRGB(50, 205, 50),
    danger = Color3.fromRGB(255, 80, 80)
}

-- Create UI
local gui = Instance.new("ScreenGui")
gui.Name = "CleanUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 500)
frame.Position = UDim2.new(0, 0, 0.5, -250)
frame.BackgroundColor3 = colors.bg
frame.BorderSizePixel = 0
frame.Parent = gui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = frame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = colors.surface
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Vortex - Highway Legends"
title.TextColor3 = colors.text
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.Parent = header

-- TABS CONTAINER
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(0, 80, 1, -45)
tabContainer.Position = UDim2.new(0, 0, 0, 45)
tabContainer.BackgroundColor3 = colors.surface
tabContainer.BorderSizePixel = 0
tabContainer.Parent = frame

-- CONTENT CONTAINER
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -90, 1, -55)
contentContainer.Position = UDim2.new(0, 85, 0, 50)
contentContainer.BackgroundColor3 = colors.surface
contentContainer.BorderSizePixel = 0
contentContainer.ClipsDescendants = true
contentContainer.Parent = frame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 12)
contentCorner.Parent = contentContainer

-- VERTICAL TAB BUTTONS
local farmTab = Instance.new("TextButton")
farmTab.Size = UDim2.new(1, 0, 0, 60)
farmTab.Position = UDim2.new(0, 0, 0, 0)
farmTab.BackgroundColor3 = colors.primary
farmTab.Text = "⚡\nFARM"
farmTab.TextColor3 = colors.text
farmTab.TextSize = 14
farmTab.Font = Enum.Font.GothamBold
farmTab.BorderSizePixel = 0
farmTab.Parent = tabContainer

local settingsTab = Instance.new("TextButton")
settingsTab.Size = UDim2.new(1, 0, 0, 60)
settingsTab.Position = UDim2.new(0, 0, 0, 65)
settingsTab.BackgroundColor3 = colors.surface
settingsTab.Text = "⚙️\nSETTINGS"
settingsTab.TextColor3 = colors.text
settingsTab.TextSize = 14
settingsTab.Font = Enum.Font.GothamBold
settingsTab.BorderSizePixel = 0
settingsTab.Parent = tabContainer

-- FARM CONTENT
local farmContent = Instance.new("ScrollingFrame")
farmContent.Size = UDim2.new(1, -15, 1, -15)
farmContent.Position = UDim2.new(0, 8, 0, 8)
farmContent.BackgroundTransparency = 1
farmContent.BorderSizePixel = 0
farmContent.ScrollBarThickness = 4
farmContent.ScrollBarImageColor3 = colors.primary
farmContent.CanvasSize = UDim2.new(0, 0, 0, 0)
farmContent.Visible = true
farmContent.Parent = contentContainer

local farmLayout = Instance.new("UIListLayout")
farmLayout.Padding = UDim.new(0, 8)
farmLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
farmLayout.SortOrder = Enum.SortOrder.LayoutOrder
farmLayout.Parent = farmContent

farmLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    farmContent.CanvasSize = UDim2.new(0, 0, 0, farmLayout.AbsoluteContentSize.Y + 15)
end)

-- SETTINGS CONTENT
local settingsContent = Instance.new("ScrollingFrame")
settingsContent.Size = UDim2.new(1, -15, 1, -15)
settingsContent.Position = UDim2.new(0, 8, 0, 8)
settingsContent.BackgroundTransparency = 1
settingsContent.BorderSizePixel = 0
settingsContent.ScrollBarThickness = 4
settingsContent.ScrollBarImageColor3 = colors.primary
settingsContent.CanvasSize = UDim2.new(0, 0, 0, 0)
settingsContent.Visible = false
settingsContent.Parent = contentContainer

local settingsLayout = Instance.new("UIListLayout")
settingsLayout.Padding = UDim.new(0, 8)
settingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
settingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
settingsLayout.Parent = settingsContent

settingsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    settingsContent.CanvasSize = UDim2.new(0, 0, 0, settingsLayout.AbsoluteContentSize.Y + 15)
end)

-- Tab switching
farmTab.MouseButton1Click:Connect(function()
    farmTab.BackgroundColor3 = colors.primary
    settingsTab.BackgroundColor3 = colors.surface
    farmContent.Visible = true
    settingsContent.Visible = false
end)

settingsTab.MouseButton1Click:Connect(function()
    settingsTab.BackgroundColor3 = colors.primary
    farmTab.BackgroundColor3 = colors.surface
    farmContent.Visible = false
    settingsContent.Visible = true
end)

-- VEHICLE TELEPORT VARIABLES (Method 2)
local vehicleTeleportEnabled = false
local vehicleStage = 1
local lastSeat = nil
local RIGHT_OFFSET = 20
local returnThread = nil

local LOCATION1 = CFrame.new(
    1842.80066, 7.43310976, 22587.7812,
    0, 0, 1,
    0, 1, -0,
    -1, 0, 0
)

local BASE_LOCATION2 = CFrame.new(
    508.259766, 30.6623974, -30810.1133,
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
)

-- ALT ASSISTANT VARIABLES
local altAssistantEnabled = false
local altStage = 1
local altLastSeat = nil
local altRIGHT_OFFSET = 20
local altSTAGE2_DELAY = 5
local altReturnThread = nil
local altStage2Thread = nil  -- NEW: thread to handle the 5s delay before stage 2 teleport

-- Function to check if already sitting when enabling (Method 2)
local function checkAlreadySitting()
    if not vehicleTeleportEnabled then return end
    
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("VehicleSeat") and v.Occupant and v.Occupant.Parent == LocalPlayer.Character then
            local vehicle = v.Parent
            while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
            
            if vehicle and vehicleStage == 1 then
                -- Already sitting, teleport to Stage 1 immediately
                vehicle:PivotTo(LOCATION1)
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then 
                    hrp.CFrame = LOCATION1 + Vector3.new(0,3,0)
                end
                vehicleStage = 2
                lastSeat = v
            end
            break
        end
    end
end

-- Function to start vehicle teleport (Method 2)
local function startVehicleTeleport()
    if not vehicleTeleportEnabled then return end
    
    -- Reset stage when starting
    vehicleStage = 1
    lastSeat = nil
    if returnThread then
        task.cancel(returnThread)
        returnThread = nil
    end
    
    -- Check if already sitting
    checkAlreadySitting()
end

-- Function to stop vehicle teleport (Method 2)
local function stopVehicleTeleport()
    vehicleStage = 1
    lastSeat = nil
    if returnThread then
        task.cancel(returnThread)
        returnThread = nil
    end
end

-- ALT ASSISTANT FUNCTIONS
local function startAltAssistant()
    if not altAssistantEnabled then return end
    
    altStage = 1
    altLastSeat = nil
    if altReturnThread then
        task.cancel(altReturnThread)
        altReturnThread = nil
    end
    if altStage2Thread then
        task.cancel(altStage2Thread)
        altStage2Thread = nil
    end
    
    -- Check if already sitting for Alt Assistant
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("VehicleSeat") and v.Occupant and v.Occupant.Parent == LocalPlayer.Character then
            local vehicle = v.Parent
            while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
            if vehicle and altStage == 1 then
                vehicle:PivotTo(LOCATION1)
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.CFrame = LOCATION1 + Vector3.new(0,3,0) end
                altStage = 2
                altLastSeat = v
            end
            break
        end
    end
end

local function stopAltAssistant()
    altStage = 1
    altLastSeat = nil
    if altReturnThread then
        task.cancel(altReturnThread)
        altReturnThread = nil
    end
    if altStage2Thread then
        task.cancel(altStage2Thread)
        altStage2Thread = nil
    end
end

-- Monitor seats
workspace.DescendantAdded:Connect(function(desc)
    task.wait(0.1)
    if desc:IsA("VehicleSeat") then
        desc:GetPropertyChangedSignal("Occupant"):Connect(function()
            -- Method 2
            if vehicleTeleportEnabled and desc.Occupant and desc.Occupant.Parent == LocalPlayer.Character then
                if lastSeat ~= desc then
                    lastSeat = desc
                    
                    local vehicle = desc.Parent
                    while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
                    
                    if vehicle then
                        if vehicleStage == 1 then
                            vehicle:PivotTo(LOCATION1)
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then 
                                hrp.CFrame = LOCATION1 + Vector3.new(0,3,0)
                            end
                            vehicleStage = 2
                            
                        elseif vehicleStage == 2 then
                            local TARGET = BASE_LOCATION2 + Vector3.new(RIGHT_OFFSET, 0, 0)
                            vehicle:PivotTo(TARGET)
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then 
                                hrp.CFrame = TARGET + Vector3.new(0,3,0)
                            end
                            
                            if returnThread then
                                task.cancel(returnThread)
                                returnThread = nil
                            end
                            
                            local vehicleRef = vehicle
                            local hrpRef = hrp
                            
                            returnThread = task.spawn(function()
                                task.wait(8)
                                if vehicleTeleportEnabled and vehicleRef and vehicleRef.Parent then
                                    vehicleRef:PivotTo(LOCATION1)
                                    if hrpRef and hrpRef.Parent then
                                        hrpRef.CFrame = LOCATION1 + Vector3.new(0,3,0)
                                    end
                                end
                                returnThread = nil
                            end)
                        end
                    end
                end
            elseif altAssistantEnabled and desc.Occupant and desc.Occupant.Parent == LocalPlayer.Character then
                -- Alt Assistant
                if altLastSeat ~= desc then
                    altLastSeat = desc
                    
                    local vehicle = desc.Parent
                    while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
                    
                    if vehicle then
                        if altStage == 1 then
                            -- FIRST SIT: Teleport to Stage 1
                            vehicle:PivotTo(LOCATION1)
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then 
                                hrp.CFrame = LOCATION1 + Vector3.new(0,3,0)
                            end
                            altStage = 2
                            
                        elseif altStage == 2 then
                            -- SECOND SIT: Wait 5 seconds THEN teleport to Stage 2
                            local vehicleRef = vehicle
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local hrpRef = hrp

                            if altStage2Thread then
                                task.cancel(altStage2Thread)
                                altStage2Thread = nil
                            end

                            altStage2Thread = task.spawn(function()
                                task.wait(10)
                                if not altAssistantEnabled then return end
                                if not (vehicleRef and vehicleRef.Parent) then return end

                                local TARGET = BASE_LOCATION2 + Vector3.new(altRIGHT_OFFSET, 0, 0)
                                vehicleRef:PivotTo(TARGET)
                                if hrpRef and hrpRef.Parent then
                                    hrpRef.CFrame = TARGET + Vector3.new(0,3,0)
                                end
                                altStage2Thread = nil

                                -- Cancel any existing return timer
                                if altReturnThread then
                                    task.cancel(altReturnThread)
                                    altReturnThread = nil
                                end

                                -- START 5 SECOND TIMER TO RETURN TO STAGE 1
                                altReturnThread = task.spawn(function()
                                    task.wait(5)
                                    if altAssistantEnabled and vehicleRef and vehicleRef.Parent then
                                        vehicleRef:PivotTo(LOCATION1)
                                        if hrpRef and hrpRef.Parent then
                                            hrpRef.CFrame = LOCATION1 + Vector3.new(0,3,0)
                                        end
                                    end
                                    altReturnThread = nil
                                end)
                            end)
                        end
                    end
                end
            else
                if lastSeat == desc then 
                    lastSeat = nil
                end
                if altLastSeat == desc then
                    altLastSeat = nil
                end
            end
        end)
    end
end)

-- Hook existing seats
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("VehicleSeat") and not v:GetAttribute("hooked") then
        v:SetAttribute("hooked", true)
        v:GetPropertyChangedSignal("Occupant"):Connect(function()
            -- Method 2
            if vehicleTeleportEnabled and v.Occupant and v.Occupant.Parent == LocalPlayer.Character then
                if lastSeat ~= v then
                    lastSeat = v
                    
                    local vehicle = v.Parent
                    while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
                    
                    if vehicle then
                        if vehicleStage == 1 then
                            vehicle:PivotTo(LOCATION1)
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then 
                                hrp.CFrame = LOCATION1 + Vector3.new(0,3,0)
                            end
                            vehicleStage = 2
                            
                        elseif vehicleStage == 2 then
                            local TARGET = BASE_LOCATION2 + Vector3.new(RIGHT_OFFSET, 0, 0)
                            vehicle:PivotTo(TARGET)
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then 
                                hrp.CFrame = TARGET + Vector3.new(0,3,0)
                            end
                            
                            if returnThread then
                                task.cancel(returnThread)
                                returnThread = nil
                            end
                            
                            local vehicleRef = vehicle
                            local hrpRef = hrp
                            
                            returnThread = task.spawn(function()
                                task.wait(5)
                                if vehicleTeleportEnabled and vehicleRef and vehicleRef.Parent then
                                    vehicleRef:PivotTo(LOCATION1)
                                    if hrpRef and hrpRef.Parent then
                                        hrpRef.CFrame = LOCATION1 + Vector3.new(0,3,0)
                                    end
                                end
                                returnThread = nil
                            end)
                        end
                    end
                end
            elseif altAssistantEnabled and v.Occupant and v.Occupant.Parent == LocalPlayer.Character then
                -- Alt Assistant
                if altLastSeat ~= v then
                    altLastSeat = v
                    
                    local vehicle = v.Parent
                    while vehicle and not vehicle:IsA("Model") do vehicle = vehicle.Parent end
                    
                    if vehicle then
                        if altStage == 1 then
                            -- FIRST SIT: Teleport to Stage 1
                            vehicle:PivotTo(LOCATION1)
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then 
                                hrp.CFrame = LOCATION1 + Vector3.new(0,3,0)
                            end
                            altStage = 2
                            
                        elseif altStage == 2 then
                            -- SECOND SIT: Wait 5 seconds THEN teleport to Stage 2
                            local vehicleRef = vehicle
                            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            local hrpRef = hrp

                            if altStage2Thread then
                                task.cancel(altStage2Thread)
                                altStage2Thread = nil
                            end

                            altStage2Thread = task.spawn(function()
                                task.wait(5)
                                if not altAssistantEnabled then return end
                                if not (vehicleRef and vehicleRef.Parent) then return end

                                local TARGET = BASE_LOCATION2 + Vector3.new(altRIGHT_OFFSET, 0, 0)
                                vehicleRef:PivotTo(TARGET)
                                if hrpRef and hrpRef.Parent then
                                    hrpRef.CFrame = TARGET + Vector3.new(0,3,0)
                                end
                                altStage2Thread = nil

                                -- Cancel any existing return timer
                                if altReturnThread then
                                    task.cancel(altReturnThread)
                                    altReturnThread = nil
                                end

                                -- START 5 SECOND TIMER TO RETURN TO STAGE 1
                                altReturnThread = task.spawn(function()
                                    task.wait(5)
                                    if altAssistantEnabled and vehicleRef and vehicleRef.Parent then
                                        vehicleRef:PivotTo(LOCATION1)
                                        if hrpRef and hrpRef.Parent then
                                            hrpRef.CFrame = LOCATION1 + Vector3.new(0,3,0)
                                        end
                                    end
                                    altReturnThread = nil
                                end)
                            end)
                        end
                    end
                end
            else
                if lastSeat == v then 
                    lastSeat = nil
                end
                if altLastSeat == v then
                    altLastSeat = nil
                end
            end
        end)
    end
end

-- Check when UI is first created
task.wait(1)
checkAlreadySitting()
if altAssistantEnabled then
    startAltAssistant()
end

-- Key controls for Alt Assistant
UserInputService.InputBegan:Connect(function(input)
    if altAssistantEnabled then
        if input.KeyCode == Enum.KeyCode.R then
            altStage = 1
            altLastSeat = nil
            if altReturnThread then
                task.cancel(altReturnThread)
                altReturnThread = nil
            end
            if altStage2Thread then
                task.cancel(altStage2Thread)
                altStage2Thread = nil
            end
        elseif input.KeyCode == Enum.KeyCode.Right then
            altRIGHT_OFFSET = altRIGHT_OFFSET + 5
        elseif input.KeyCode == Enum.KeyCode.Left then
            altRIGHT_OFFSET = altRIGHT_OFFSET - 5
        end
    end
end)

-- Helper: Create toggle
local function createToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 35)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = colors.text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = toggleFrame
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 44, 0, 22)
    bg.Position = UDim2.new(1, -54, 0.5, -11)
    bg.BackgroundColor3 = default and colors.success or colors.danger
    bg.BackgroundTransparency = 0.2
    bg.BorderSizePixel = 0
    bg.Parent = toggleFrame
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = bg
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = colors.text
    circle.BorderSizePixel = 0
    circle.Parent = bg
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle
    
    local state = default
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = toggleFrame
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        bg.BackgroundColor3 = state and colors.success or colors.danger
        circle:TweenPosition(
            state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.1,
            true
        )
        if callback then
            callback(state)
        end
    end)
end

-- Helper: Create slider
local function createSlider(parent, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 45)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 18)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = colors.text
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Parent = sliderFrame
    
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 4)
    bar.Position = UDim2.new(0, 0, 0, 28)
    bar.BackgroundColor3 = colors.bg
    bar.BorderSizePixel = 0
    bar.Parent = sliderFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = colors.primary
    fill.BorderSizePixel = 0
    fill.Parent = bar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local value = default
    local dragging = false
    
    local function update(input)
        local pos = UserInputService:GetMouseLocation()
        local absPos = bar.AbsolutePosition
        local size = bar.AbsoluteSize.X
        local rel = math.clamp((pos.X - absPos.X) / size, 0, 1)
        value = min + (max - min) * rel
        value = math.floor(value * 10) / 10
        fill.Size = UDim2.new(rel, 0, 1, 0)
        label.Text = text .. ": " .. value
        if callback then
            callback(value)
        end
    end
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ===== AUTO FARM CONTENT =====
local farmTitle = Instance.new("TextLabel")
farmTitle.Size = UDim2.new(1, -20, 0, 30)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "⚡ AUTO FARM"
farmTitle.TextColor3 = colors.primary
farmTitle.TextSize = 16
farmTitle.TextXAlignment = Enum.TextXAlignment.Left
farmTitle.Font = Enum.Font.GothamBold
farmTitle.Parent = farmContent

-- METHOD 1 SECTION
local method1Title = Instance.new("TextLabel")
method1Title.Size = UDim2.new(1, -20, 0, 25)
method1Title.BackgroundTransparency = 1
method1Title.Text = "AUTO FARM - METHOD 1"
method1Title.TextColor3 = colors.primary
method1Title.TextSize = 14
method1Title.TextXAlignment = Enum.TextXAlignment.Left
method1Title.Font = Enum.Font.GothamBold
method1Title.Parent = farmContent

createToggle(farmContent, "Auto Farm Method 1", false)
createSlider(farmContent, "Speed", 1, 20, 5)

-- Divider
local divider1 = Instance.new("Frame")
divider1.Size = UDim2.new(1, -20, 0, 1)
divider1.BackgroundColor3 = colors.text2
divider1.BackgroundTransparency = 0.7
divider1.Parent = farmContent

-- METHOD 2 SECTION - VEHICLE TELEPORT
local method2Title = Instance.new("TextLabel")
method2Title.Size = UDim2.new(1, -20, 0, 25)
method2Title.BackgroundTransparency = 1
method2Title.Text = "AUTO FARM - METHOD 2"
method2Title.TextColor3 = colors.primary
method2Title.TextSize = 14
method2Title.TextXAlignment = Enum.TextXAlignment.Left
method2Title.Font = Enum.Font.GothamBold
method2Title.Parent = farmContent

-- Vehicle teleport toggle
createToggle(farmContent, "Auto Farm Method 2", false, function(state)
    vehicleTeleportEnabled = state
    if state then
        startVehicleTeleport()
    else
        stopVehicleTeleport()
    end
end)

-- Alt Assistant toggle (NOW MATCHES METHOD 2 BEHAVIOR)
createToggle(farmContent, "Alt Assistant", false, function(state)
    altAssistantEnabled = state
    if state then
        startAltAssistant()
    else
        stopAltAssistant()
    end
end)

-- ===== SETTINGS CONTENT =====
local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, -20, 0, 30)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "⚙️ SETTINGS"
settingsTitle.TextColor3 = colors.primary
settingsTitle.TextSize = 16
settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.Parent = settingsContent

local settingsDesc = Instance.new("TextLabel")
settingsDesc.Size = UDim2.new(1, -20, 0, 40)
settingsDesc.BackgroundTransparency = 1
settingsDesc.Text = "Click below to remove the UI"
settingsDesc.TextColor3 = colors.text2
settingsDesc.TextSize = 13
settingsDesc.TextWrapped = true
settingsDesc.Font = Enum.Font.Gotham
settingsDesc.Parent = settingsContent

local spacer = Instance.new("Frame")
spacer.Size = UDim2.new(1, -20, 0, 15)
spacer.BackgroundTransparency = 1
spacer.Parent = settingsContent

-- UNLOAD BUTTON
local unloadBtn = Instance.new("TextButton")
unloadBtn.Size = UDim2.new(1, -20, 0, 50)
unloadBtn.BackgroundColor3 = colors.danger
unloadBtn.Text = "⛔ UNLOAD UI ⛔"
unloadBtn.TextColor3 = colors.text
unloadBtn.TextSize = 16
unloadBtn.Font = Enum.Font.GothamBold
unloadBtn.BorderSizePixel = 0
unloadBtn.Parent = settingsContent

local unloadCorner = Instance.new("UICorner")
unloadCorner.CornerRadius = UDim.new(0, 8)
unloadCorner.Parent = unloadBtn

unloadBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Make draggable
local dragging = false
local dragOffset

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragOffset = Vector2.new(Mouse.X - frame.AbsolutePosition.X, Mouse.Y - frame.AbsolutePosition.Y)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        frame.Position = UDim2.new(0, Mouse.X - dragOffset.X, 0, Mouse.Y - dragOffset.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Floating toggle button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 15, 1, -60)
toggleBtn.BackgroundColor3 = colors.primary
toggleBtn.Text = "⚡"
toggleBtn.TextColor3 = colors.text
toggleBtn.TextSize = 20
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = gui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleBtn

local menuVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    frame.Visible = menuVisible
end)
