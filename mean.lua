--// Rivals GhostStep Loader + Bypass GUI (GitHub raw용 단일 스크립트)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GhostBypassLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- 메인 검은 네모 (모서리 둥글게)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 340, 0, 400)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 28)
corner.Parent = mainFrame

-- 회전하는 이미지 (너가 준 ID)
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(0, 160, 0, 160)
image.Position = UDim2.new(0.5, -80, 0.32, -80)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://85857301097273"
image.AnchorPoint = Vector2.new(0.5, 0.5)
image.Parent = mainFrame

local imgCorner = Instance.new("UICorner")
imgCorner.CornerRadius = UDim.new(1, 0)
imgCorner.Parent = image

-- 로딩중 텍스트
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0.58, 0)
title.BackgroundTransparency = 1
title.Text = "로딩중..."
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- 안티치트 우회 과정 텍스트
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 35)
status.Position = UDim2.new(0, 20, 0.72, 0)
status.BackgroundTransparency = 1
status.Text = "안티치트 우회 중..."
status.TextColor3 = Color3.fromRGB(160, 160, 160)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = mainFrame

-- 로딩바 배경
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.82, 0, 0, 14)
barBg.Position = UDim2.new(0.09, 0, 0.85, 0)
barBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
barBg.BorderSizePixel = 0
barBg.Parent = mainFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg

-- 로딩바 채우기
local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = barFill

-- 등장 애니메이션
local TS = game:GetService("TweenService")
mainFrame.Size = UDim2.new(0, 120, 0, 120)
mainFrame.BackgroundTransparency = 1

TS:Create(mainFrame, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 340, 0, 400),
    BackgroundTransparency = 0
}):Play()

-- 이미지 빙빙 돌리기
TS:Create(image, TweenInfo.new(2.4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 360}):Play()

-- 로딩 진행 (3.2 \~ 6초 랜덤)
local loadTime = math.random(32, 60) / 10

TS:Create(barFill, TweenInfo.new(loadTime, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

-- 상태 텍스트 단계별 변경
task.spawn(function()
    task.wait(0.9)
    status.Text = "Hyperion 우회 중..."
    task.wait(1.2)
    status.Text = "Server-side validation bypass..."
    task.wait(1.4)
    status.Text = "Physics desync initializing..."
    task.wait(1.1)
    status.Text = "GhostStep module loading..."
end)

-- 로딩 완료 후
task.wait(loadTime + 0.4)
status.Text = "완료"

task.wait(0.8)

-- 여기에 너의 실제 GhostStep 스크립트 넣으면 됨 (로딩 끝난 후 실행)
print("로딩 완료 → GhostStep 시작")

-- ================== 여기부터 너의 실제 Ghost 코드 넣어 ==================
-- 예시: LocalGhost:Toggle(true) 같은 거

-- 만약 Ghost 코드를 별도로 loadstring으로 불러오고 싶으면 여기서 추가
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/너의아이디/레포/main/ghost.lua"))()

-- GUI 자동 제거 (원하면 주석 처리)
task.wait(1.2)
screenGui:Destroy()
