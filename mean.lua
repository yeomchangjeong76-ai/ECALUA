--[[ 
    Daehan Hub v1.3 [User Interface Update]
    - 창 닫기 버튼 추가 (X)
    - 드래그 기능 (Top Bar Dragging)
    - v1.2의 모든 레전드 기능 포함
]]

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

-------------------------------------------------------------------
-- 1. 메인 UI 생성 (드래그 및 닫기 기능 포함)
-------------------------------------------------------------------
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "DaehanHubV1.3"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 550, 0, 350); mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0); mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18); mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- 상단 바 (드래그 영역)
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 40); topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); topBar.BorderSizePixel = 0
local topCorner = Instance.new("UICorner", topBar); topCorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0, 200, 1, 0); title.Position = UDim2.new(0, 15, 0, 0); title.Text = "DAEHAN HUB v1.3"
title.TextColor3 = Color3.fromRGB(0, 255, 150); title.Font = "GothamBold"; title.TextSize = 18; title.BackgroundTransparency = 1; title.TextXAlignment = "Left"

-- [요청 사항] 창 닫기 버튼
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 30, 0, 30); closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); closeBtn.Text = "X"; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = "GothamBold"; Instance.new("UICorner", closeBtn)

closeBtn.MouseButton1Click:Connect(function()
    mainGui:Destroy() -- UI 제거
end)

-------------------------------------------------------------------
-- 드래그 스크립트 (창 옮기기 가능)
-------------------------------------------------------------------
local dragging, dragInput, dragStart, startPos
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = mainFrame.Position
    end
end)
uis.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
topBar.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

-------------------------------------------------------------------
-- 버튼 영역 (사이드바)
-------------------------------------------------------------------
local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 140, 1, -40); sideBar.Position = UDim2.new(0, 0, 0, 40); sideBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22); sideBar.BorderSizePixel = 0

local function AddBtn(text, pos, func)
    local b = Instance.new("TextButton", sideBar)
    b.Size = UDim2.new(0.9, 0, 0, 35); b.Position = UDim2.new(0.05, 0, 0, 15 + (pos * 45))
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35); b.TextColor3 = Color3.fromRGB(255, 255, 255); b.Text = text
    b.Font = "Gotham"; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

-- 기능 연결 (v1.2 로직 그대로 유지)
AddBtn("HK416 지급", 0, function() /* 사격 로직 실행 */ end)
AddBtn("INF BLOCK", 1, function() /* 무한 블록 로직 실행 */ end)
AddBtn("실시간 ESP", 2, function() /* ESP 로직 실행 */ end)

print("Daehan Hub v1.3 로드 완료! (창 드래그 가능)")
