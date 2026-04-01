--// Rivals GhostStep v6.0 + Bypass GUI Loader (통합 버전)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. GUI 생성 및 설정
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GhostBypassLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true -- 화면 전체 기준
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 400)
-- [중앙 정렬 핵심] AnchorPoint와 Position 조합
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 28)
corner.Parent = mainFrame

-- UI 요소들 (이미지, 텍스트, 로딩바)
local image = Instance.new("ImageLabel")
image.Size = UDim2.new(0, 160, 0, 160)
image.Position = UDim2.new(0.5, 0, 0.32, 0)
image.AnchorPoint = Vector2.new(0.5, 0.5)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://85857301097273"
image.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0.58, 0)
title.BackgroundTransparency = 1
title.Text = "로딩중..."
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 35)
status.Position = UDim2.new(0.5, 0, 0.72, 0)
status.AnchorPoint = Vector2.new(0.5, 0.5)
status.BackgroundTransparency = 1
status.Text = "안티치트 우회 중..."
status.TextColor3 = Color3.fromRGB(160, 160, 160)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = mainFrame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.82, 0, 0, 14)
barBg.Position = UDim2.new(0.5, 0, 0.85, 0)
barBg.AnchorPoint = Vector2.new(0.5, 0.5)
barBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
barBg.Parent = mainFrame

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
barFill.Parent = barBg

-- 애니메이션 및 로직
local TS = game:GetService("TweenService")
mainFrame.Size = UDim2.new(0, 120, 0, 120)
mainFrame.BackgroundTransparency = 1
TS:Create(mainFrame, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 340, 0, 400), BackgroundTransparency = 0}):Play()
TS:Create(image, TweenInfo.new(2.4, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 360}):Play()

local loadTime = math.random(32, 60) / 10
TS:Create(barFill, TweenInfo.new(loadTime, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()

task.spawn(function()
    task.wait(0.9); status.Text = "Hyperion 우회 중..."
    task.wait(1.2); status.Text = "Server-side validation bypass..."
    task.wait(1.4); status.Text = "Physics desync initializing..."
    task.wait(1.1); status.Text = "GhostStep v6.0 loading..."
end)

-- 2. GhostStep v6.0 로직
task.wait(loadTime + 0.4)
status.Text = "완료!"
task.wait(0.5)

local LocalGhost = { Active = false, Root = nil, Connection = nil, Attachment = nil, VectorForce = nil, Tick = 0, LastMoveTime = 0 }

function LocalGhost:Toggle(state)
    if self.Connection then self.Connection:Disconnect() end
    if self.VectorForce then self.VectorForce:Destroy() end
    if self.Attachment then self.Attachment:Destroy() end
    if not state then self.Active = false return end

    local char = game.Players.LocalPlayer.Character
    self.Root = char and char:FindFirstChild("HumanoidRootPart")
    if not self.Root then return end

    self.Active = true
    self.Tick = 0
    self.LastMoveTime = tick()
    self.Attachment = Instance.new("Attachment", self.Root)
    self.VectorForce = Instance.new("VectorForce", self.Root)
    self.VectorForce.Attachment0 = self.Attachment
    self.VectorForce.ApplyAtCenterOfMass = true
    self.VectorForce.RelativeTo = Enum.ActuationRelativeTo.World

    self.Connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
        if not self.Root or not self.Root.Parent then self:Toggle(false) return end
        self.Tick += 1
        local now = tick()
        if (self.Tick % 3 == 0) and (now - self.LastMoveTime > 0.052) then
            local intensity = 550 + math.random() * 350
            local fx = math.noise(self.Tick * 0.068) * 0.19
            local fz = math.noise(self.Tick * 0.085 + 60) * 0.18
            local fy = (math.random() - 0.5) * 0.028
            self.VectorForce.Force = Vector3.new(fx, fy, fz) * intensity
            task.delay(0.029 + dt * 0.75, function()
                if self.VectorForce and self.VectorForce.Parent then self.VectorForce.Force = Vector3.new(0, 0, 0) end
            end)
            self.LastMoveTime = now
        end
        if self.Tick > 580 then self.Tick = math.random(35, 105) end
    end)
end

LocalGhost:Toggle(true)
print("GhostStep v6.0 Activated")

-- GUI 제거
task.wait(1.5)
screenGui:Destroy()
