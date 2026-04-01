--[[ 
    Daehan Hub v1.2 [Babft Legendary Edition] 
    - 통합 업데이트: Raycast(Wallbang), Real-time ESP, Auto Farm
    - 핵심 수정 1 (Babft): Physics Joint Destruction (분해 살상)
    - 핵심 수정 2 (Babft): Stage Teleport Gold Farm (실제 골드 파밍)
    - 기능 추가: 창 닫기 버튼(×) 및 단축키(RightControl) 토글
]]

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

-------------------------------------------------------------------
-- 1. 로더 GUI (시각적 로딩 효과)
-------------------------------------------------------------------
local loaderGui = Instance.new("ScreenGui", playerGui)
loaderGui.Name = "DaehanLoader"; loaderGui.ResetOnSpawn = false

local loadFrame = Instance.new("Frame", loaderGui)
loadFrame.Size = UDim2.new(0, 340, 0, 400); loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0); loadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); loadFrame.BorderSizePixel = 0
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 20)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1, 0, 0, 50); loadText.Position = UDim2.new(0, 0, 0.6, 0); loadText.Text = "Daehan Hub v1.2 [Babft] 로딩 중..."
loadText.TextColor3 = Color3.fromRGB(255, 255, 255); loadText.Font = "GothamBold"; loadText.TextSize = 20; loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.8, 0, 0, 10); barBg.Position = UDim2.new(0.1, 0, 0.75, 0); barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30); barBg.BorderSizePixel = 0
local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 120); barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill); Instance.new("UICorner", barBg)

ts:Create(barFill, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1.7); loaderGui:Destroy()

-------------------------------------------------------------------
-- 2. 메인 허브 UI (Legendary 스타일)
-------------------------------------------------------------------
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "DaehanHub_Babft"; mainGui.ResetOnSpawn = false; mainGui.Enabled = true

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 600, 0, 380); mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0); mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); mainFrame.BorderSizePixel = 0
mainFrame.Active = true; mainFrame.Draggable = true 
Instance.new("UICorner", mainFrame)

-- 상단 타이틀 바 & 닫기 버튼
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 30); topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); topBar.BorderSizePixel = 0
local topCorner = Instance.new("UICorner", topBar); topCorner.CornerRadius = UDim.new(0, 8)
local bottomFix = Instance.new("Frame", topBar)
bottomFix.Size = UDim2.new(1, 0, 0.5, 0); bottomFix.Position = UDim2.new(0, 0, 0.5, 0); bottomFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local titleText = Instance.new("TextLabel", topBar)
titleText.Size = UDim2.new(0, 250, 1, 0); titleText.Position = UDim2.new(0, 10, 0, 0); titleText.Text = "Daehan Hub v1.2 - Babft Special"
titleText.TextColor3 = Color3.fromRGB(200, 200, 200); titleText.Font = "GothamBold"; titleText.TextSize = 14; titleText.TextXAlignment = "Left"; titleText.BackgroundTransparency = 1

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 24, 0, 24); closeBtn.Position = UDim2.new(1, -27, 0.5, 0); closeBtn.AnchorPoint = Vector2.new(0, 0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); closeBtn.Text = "×"; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); closeBtn.Font = "GothamBold"; closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function() mainGui.Enabled = false end)
uis.InputBegan:Connect(function(input, gpe) if not gpe and input.KeyCode == Enum.KeyCode.RightControl then mainGui.Enabled = not mainGui.Enabled end end)

-- 사이드바
local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 160, 1, -30); sideBar.Position = UDim2.new(0, 0, 0, 30); sideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local logoLabel = Instance.new("TextLabel", sideBar)
logoLabel.Size = UDim2.new(1, 0, 0, 60); logoLabel.Text = "BABFT"; logoLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
logoLabel.Font = "GothamBlack"; logoLabel.TextSize = 28; logoLabel.BackgroundTransparency = 1

local buttonFrame = Instance.new("Frame", sideBar)
buttonFrame.Size = UDim2.new(1, 0, 1, -70); buttonFrame.Position = UDim2.new(0, 0, 0, 70); buttonFrame.BackgroundTransparency = 1

local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", buttonFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, (pos*45))
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.Text = name; btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = "GothamMedium"; btn.TextSize = 13; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-------------------------------------------------------------------
-- 3. Babft 전용 기능 (Special Logic)
-------------------------------------------------------------------

-- [기능 1] Babft 분해 살상 (Physics Void)
local function ShootHK416()
    local tool = Instance.new("Tool", player.Backpack); tool.Name = "🔥 HK416 [VOID KILL]"
    local handle = Instance.new("Part", tool); handle.Name = "Handle"; handle.Size = Vector3.new(0.5, 1, 3.5)
    Instance.new("SpecialMesh", handle).MeshId = "rbxassetid://4701290654"
    
    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
            local enemy = mouse.Target.Parent
            for _, v in pairs(enemy:GetDescendants()) do if v:IsA("Motor6D") or v:IsA("Weld") then v:Destroy() end end
            enemy:MoveTo(Vector3.new(0, -500, 0))
        end
        local b = Instance.new("Part", workspace); b.Anchored = true; b.CanCollide = false; b.Color = Color3.fromRGB(0,255,120); b.Material = "Neon"
        b.Size = Vector3.new(0.1, 0.1, (handle.Position - mouse.Hit.p).Magnitude); b.CFrame = CFrame.lookAt(handle.Position:Lerp(mouse.Hit.p, 0.5), mouse.Hit.p)
        game.Debris:AddItem(b, 0.05)
    end)
end

-- [기능 2] Babft 자동 골드 파밍 (Real Gold)
local farming = false
local function ToggleAutoFarm()
    farming = not farming
    print("Auto Farm: ", farming)
    task.spawn(function()
        while farming and task.wait(0.5) do
            local stages = workspace:FindFirstChild("BoatStages")
            if stages and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for i = 1, 10 do
                    if not farming then break end
                    local s = stages.NormalStages:FindFirstChild("Stage"..i)
                    if s and s:FindFirstChild("GoldenChest") then
                        player.Character.HumanoidRootPart.CFrame = s.GoldenChest.Part.CFrame
                        task.wait(0.7)
                    end
                end
            end
        end
    end)
end

-- [기능 3] 실시간 ESP (기존 유지)
local espEnabled = false
local function ToggleESP()
    espEnabled = not espEnabled
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
            if v.Character.Head:FindFirstChild("ESP") then v.Character.Head.ESP:Destroy() end
            if espEnabled then
                local bg = Instance.new("BillboardGui", v.Character.Head); bg.Name = "ESP"; bg.Size = UDim2.new(0, 200, 0, 50); bg.AlwaysOnTop = true
                local tl = Instance.new("TextLabel", bg); tl.Size = UDim2.new(1, 0, 1, 0); tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.fromRGB(255,255,255)
                rs.RenderStepped:Connect(function() if bg.Parent then tl.Text = v.Name .. " [" .. math.floor((player.Character.Head.Position - v.Character.Head.Position).Magnitude) .. "m]" end end)
            end
        end
    end
end

-------------------------------------------------------------------
-- 버튼 연결
-------------------------------------------------------------------
CreateButton("HK416 [분해 살상]", 0, ShootHK416)
CreateButton("자동 골드 파밍 [ON/OFF]", 1, ToggleAutoFarm)
CreateButton("실시간 ESP 토글", 2, ToggleESP)
CreateButton("바다 제거", 3, function()
    for _, v in pairs(workspace:GetDescendants()) do if v.Name == "Water" or v:IsA("Terrain") then v:Destroy() end end
end)

print("Daehan Hub v1.2 [Babft Edition] Loaded!")

