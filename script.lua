-- Drawn Obby INFINITE INK / @Find_Nulla1 
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- *** GUI GIGANTE + DRAG ***
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.Name = "InfiniteInkGiant"
gui.ResetOnSpawn = false

-- FRAME GIGANTE 300x90
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 90)
frame.Position = UDim2.new(1, -310, 0, 20)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(0, 1, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

-- BOTÃO GIGANTE (1 CLIQUE = ATIVA)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -20, 1, -20)
btn.Position = UDim2.new(0, 10, 0, 10)
btn.Text = "🖌️ INK ∞"
btn.BackgroundColor3 = Color3.new(0, 0.8, 0)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.SourceSansBold
btn.TextSize = 28
btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = btn

-- *** DRAG MOBILE/PC ***
local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- *** FUNÇÃO INFINITE INK ***
local function startInfiniteInk()
    local connection = RunService.Heartbeat:Connect(function()
        -- Profiles
        local success1, profiles = pcall(require, ReplicatedStorage.Libraries.Modules.Profiles)
        if success1 then
            local replica = profiles:GetPlayerReplica(player)
            if replica and replica.Data then
                replica.Data.hints = 999999
            end
        end
        
        -- Draw
        local success2, Draw = pcall(require, ReplicatedStorage.Libraries.Game.Draw)
        if success2 then
            pcall(function() Draw.ink = 999999 end)
            pcall(function() Draw:SetInk(999999) end)
        end
        
        -- UI
        local DrawUI = player.PlayerGui:FindFirstChild("DrawUI")
        if DrawUI and DrawUI.Buttons.Hint then
            DrawUI.Buttons.Hint.Content.Label.Text = "Hints(∞)"
        end
    end)
end

-- *** 1 CLIQUE = ATIVA PRA SEMPRE ***
btn.MouseButton1Click:Connect(function()
    -- MUDA BOTÃO (1 VEZ SÓ)
    btn.Text = "🖌️ INK Infinity ∞"
    btn.BackgroundColor3 = Color3.new(0, 0.8, 0)
    btn.TextSize = 28
    
    -- ATIVA INFINITE INK
    startInfiniteInk()
    
    print("🖌️ INFINITE INK: ATIVADO PRA SEMPRE!")
end)

print("🖌️ INFINITE INK CARREGADO! (CLIQUE 1X = ∞)")
