--[[ 
    Daehan Hub v1.2 [HACKED Edition] 
    - 통합 업데이트: Raycast(Wallbang), Real-time ESP, NumberValue INF BLOCK
    - 핵심 수정 1 (HACK): TakeDamage -> RemoteEvent Hijacking (실제 살상)
    - 핵심 수정 2 (HACK): Visual Gold -> Server-Side Gold Remote (실제 골드 지급 시도)
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
loaderGui.Name = "DaehanLoader"
loaderGui.ResetOnSpawn = false

local loadFrame = Instance.new("Frame", loaderGui)
loadFrame.Size = UDim2.new(0, 340, 0, 400); loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0); loadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); loadFrame.BorderSizePixel = 0
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 20)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1, 0, 0, 50); loadText.Position = UDim2.new(0, 0, 0.6, 0); loadText.Text = "Daehan Hub v1.2 [HACKED] 로딩 중..."
loadText.TextColor3 = Color3.fromRGB(255, 255, 255); loadText.Font = "GothamBold"; loadText.TextSize = 20; loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.8, 0, 0, 10); barBg.Position = UDim2.new(0.1, 0, 0.75, 0); barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30); barBg.BorderSizePixel = 0
local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0); barFill.BorderSizePixel = 0 -- 해킹 에디션은 빨간색
Instance.new("UICorner", barFill)
Instance.new("UICorner", barBg)

ts:Create(barFill, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(1.7); loaderGui:Destroy()

-------------------------------------------------------------------
-- 2. 메인 허브 UI (HACKED 스타일)
-------------------------------------------------------------------
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "DaehanHub_v1.2_Hacked"
mainGui.ResetOnSpawn = false
mainGui.Enabled = true

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 600, 0, 380); mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0); mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); mainFrame.BorderSizePixel = 0 -- 더 어둡게
mainFrame.Active = true; mainFrame.Draggable = true 
Instance.new("UICorner", mainFrame)

-- 상단 타이틀 바 & 닫기 버튼
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 30); topBar.BackgroundColor3 = Color3.fromRGB(20, 0, 0); topBar.BorderSizePixel = 0 -- 붉은색
local topCorner = Instance.new("UICorner", topBar); topCorner.CornerRadius = UDim.new(0, 8)
local bottomFix = Instance.new("Frame", topBar)
bottomFix.Size = UDim2.new(1, 0, 0.5, 0); bottomFix.Position = UDim2.new(0, 0, 0.5, 0); bottomFix.BackgroundColor3 = Color3.fromRGB(20, 0, 0); bottomFix.BorderSizePixel = 0

local titleText = Instance.new("TextLabel", topBar)
titleText.Size = UDim2.new(0, 250, 1, 0); titleText.Position = UDim2.new(0, 10, 0, 0); titleText.Text = "Daehan Hub v1.2 - [HACKED Edition]"
titleText.TextColor3 = Color3.fromRGB(255, 50, 50); titleText.Font = "GothamBold"; titleText.TextSize = 14; titleText.TextXAlignment = "Left"; titleText.BackgroundTransparency = 1

-- 창 닫기 버튼 (×)
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -27, 0.5, 0); closeBtn.AnchorPoint = Vector2.new(0, 0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0); closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); closeBtn.Font = "GothamBold"; closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function() mainGui.Enabled = false end)

-- 단축키 토글 (RightControl)
uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        mainGui.Enabled = not mainGui.Enabled
    end
end)

-- 사이드바
local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 160, 1, -30); sideBar.Position = UDim2.new(0, 0, 0, 30)
sideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15); sideBar.BorderSizePixel = 0

local logoLabel = Instance.new("TextLabel", sideBar)
logoLabel.Size = UDim2.new(1, 0, 0, 60); logoLabel.Position = UDim2.new(0, 0, 0, 0)
logoLabel.Text = "HACKED"; logoLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
logoLabel.Font = "GothamBlack"; logoLabel.TextSize = 28; logoLabel.BackgroundTransparency = 1

local buttonFrame = Instance.new("Frame", sideBar)
buttonFrame.Size = UDim2.new(1, 0, 1, -70); buttonFrame.Position = UDim2.new(0, 0, 0, 70); buttonFrame.BackgroundTransparency = 1

local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", buttonFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, (pos*45))
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0); btn.BorderSizePixel = 0
    btn.Text = name; btn.TextColor3 = Color3.fromRGB(255, 200, 200)
    btn.Font = "GothamMedium"; btn.TextSize = 13
    Instance.new("UICorner", btn)
    
    btn.MouseEnter:Connect(function() ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 0, 0)}):Play() end)
    btn.MouseLeave:Connect(function() ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 0, 0)}):Play() end)
    
    btn.MouseButton1Click:Connect(callback)
end

-------------------------------------------------------------------
-- 3. 핵심 해킹 기능 (HACKED)
-------------------------------------------------------------------

-- [자동 탐색 변수]
local killRemote = nil
local goldRemote = nil

-- 게임 내 리모트 이벤트 자동 스캔 함수
local function ScanRemotes()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            local name = v.Name:lower()
            -- 공격 리모트 탐색
            if not killRemote and (name:find("hit") or name:find("damage") or name:find("shot") or name:find("attack")) then
                killRemote = v
                print("공격 리모트 발견: " .. v:GetFullName())
            end
            -- 골드 리모트 탐색
            if not goldRemote and (name:find("give") or name:find("add") or name:find("reward") or name:find("cash") or name:find("gold") or name:find("money")) then
                -- 단순히 이름만 있는게 아니라 값을 인자로 받을 확률이 높은 리모트
                goldRemote = v
                print("골드 리모트 발견: " .. v:GetFullName())
            end
        end
    end
end
ScanRemotes() -- 시작 시 스캔

-- [기능 1] HACKED HK416 (Remote Hijacking + Instakill)
local function ShootHK416()
    local tool = Instance.new("Tool"); tool.Name = "🔥 HK416 [INSTAKILL]"; tool.Parent = player.Backpack
    local handle = Instance.new("Part"); handle.Name = "Handle"; handle.Size = Vector3.new(0.5, 1, 3.5); handle.Parent = tool
    local mesh = Instance.new("SpecialMesh"); mesh.MeshId = "rbxassetid://4701290654"; mesh.Scale = Vector3.new(0.05, 0.05, 0.05); mesh.Parent = handle
    
    if not killRemote then ScanRemotes() end -- 리모트 못 찾았으면 재스캔

    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local startPos = handle.Position
        local targetPos = mouse.Hit.p
        local targetPart = mouse.Target

        -- 시각적 레이저 효과 (Wallbang 시각화)
        local beam = Instance.new("Part", workspace)
        beam.Anchored = true; beam.CanCollide = false; beam.Material = Enum.Material.Neon; beam.Color = Color3.fromRGB(255, 0, 0)
        beam.Size = Vector3.new(0.2, 0.2, (startPos - targetPos).Magnitude)
        beam.CFrame = CFrame.lookAt(startPos:Lerp(targetPos, 0.5), targetPos)
        game.Debris:AddItem(beam, 0.03)

        -- 실제 대미지 (HACK)
        if targetPart and targetPart.Parent:FindFirstChild("Humanoid") then
            local enemyModel = targetPart.Parent
            local enemyHum = enemyModel.Humanoid
            
            if enemyModel ~= player.Character then
                -- 1단계: 강제 피 0 설정 (시각적 + 일부 취약 게임용)
                enemyHum.Health = 0
                
                -- 2단계: 서버 리모트 하이재킹 (서버에 죽음 신호 전송)
                if killRemote then
                    -- 게임마다 인자(Argument) 형식이 다름. 일반적인 형식으로 시도.
                    killRemote:FireServer(enemyHum, 100, targetPart.Position, targetPart) 
                    killRemote:FireServer(enemyModel, "Head", 999) -- 헤드샷 판정 시도
                end
                
                -- 3단계: (최후의 수단) 도구 자체 리모트 탐색 후 공격
                local toolRemote = tool:FindFirstChildOfClass("RemoteEvent") or enemyModel:FindFirstChildOfClass("RemoteEvent")
                if toolRemote then toolRemote:FireServer(targetPart.Position, enemyModel) end
            end
        end
    end)
    print("HK416 [INSTAKILL] 지급 완료")
end

-- [기능 2] HACKED GOLD (Server-Side INF - 시각적 ㄴㄴ)
local function EnableRealGold()
    if not goldRemote then ScanRemotes() end -- 리모트 못 찾았으면 재스캔
    
    if goldRemote then
        print("서버에 골드 지급 리모트 신호 전송 시도: " .. goldRemote.Name)
        -- 게임마다 인자 형식이 다름. 가능한 여러 형식으로 시도.
        goldRemote:FireServer(9999999) -- 숫자만 전송
        goldRemote:FireServer(player, 9999999) -- 플레이어와 숫자 전송
        goldRemote:FireServer("Gold", 9999999) -- 이름과 숫자 전송
        
        -- 루프 돌며 지속적으로 지급 시도 (게임 보안에 따라 킥 당할 수도 있음)
        task.spawn(function()
            for i = 1, 10 do
                if not goldRemote then break end
                goldRemote:FireServer(100000) 
                task.wait(0.5)
            end
        end)
    else
        print("골드 관련 서버 리모트를 자동으로 찾지 못했습니다. 보안이 강력하거나 경로가 특이합니다.")
    end
end

-- [기능 3] 실시간 ESP (기존 내용 유지)
local espEnabled = false
local espCons = {}
local function ToggleESP()
    espEnabled = not espEnabled
    print("ESP 상태: ", espEnabled)
    for _, c in pairs(espCons) do c:Disconnect() end; espCons = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("Daehan_ESP") then
            v.Character.Head.Daehan_ESP:Destroy()
        end
    end

    if espEnabled then
        local function addESP(v)
            if v == player then return end
            v.CharacterAdded:Connect(function(char)
                task.wait(0.5)
                if not espEnabled then return end
                local head = char:WaitForChild("Head", 10)
                if head then
                    local bg = Instance.new("BillboardGui", head); bg.Name = "Daehan_ESP"; bg.Size = UDim2.new(0, 200, 0, 50); bg.AlwaysOnTop = true
                    local tl = Instance.new("TextLabel", bg); tl.Size = UDim2.new(1, 0, 1, 0); tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.fromRGB(255, 255, 255); tl.Font = "GothamBold"; tl.TextSize = 12
                    local con = rs.RenderStepped:Connect(function()
                        if not espEnabled or not v.Character or not v.Character:FindFirstChild("Head") then tl.Text = ""; return end
                        local dist = math.floor((player.Character.Head.Position - head.Position).Magnitude)
                        tl.Text = string.format("%s [%d m]", v.DisplayName, dist)
                        if dist < 50 then tl.TextColor3 = Color3.fromRGB(255, 50, 50)
                        elseif dist < 100 then tl.TextColor3 = Color3.fromRGB(255, 255, 50)
                        else tl.TextColor3 = Color3.fromRGB(50, 255, 50) end
                    end)
                    table.insert(espCons, con)
                end
            end)
            if v.Character and v.Character:FindFirstChild("Head") then
                local head = v.Character.Head
                if head:FindFirstChild("Daehan_ESP") then head.Daehan_ESP:Destroy() end
                local bg = Instance.new("BillboardGui", head); bg.Name = "Daehan_ESP"; bg.Size = UDim2.new(0, 200, 0, 50); bg.AlwaysOnTop = true
                local tl = Instance.new("TextLabel", bg); tl.Size = UDim2.new(1, 0, 1, 0); tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.fromRGB(255, 255, 255); tl.Font = "GothamBold"; tl.TextSize = 12
                local con = rs.RenderStepped:Connect(function()
                    if not espEnabled or not v.Character or not v.Character:FindFirstChild("Head") then return end
                    local dist = math.floor((player.Character.Head.Position - v.Character.Head.Position).Magnitude)
                    tl.Text = string.format("%s [%d m]", v.DisplayName, dist)
                     if dist < 50 then tl.TextColor3 = Color3.fromRGB(255, 50, 50)
                     elseif dist < 100 then tl.TextColor3 = Color3.fromRGB(255, 255, 50)
                     else tl.TextColor3 = Color3.fromRGB(50, 255, 50) end
                end)
                table.insert(espCons, con)
            end
        end
        for _, v in pairs(game.Players:GetPlayers()) do addESP(v) end
        table.insert(espCons, game.Players.PlayerAdded:Connect(addESP))
    end
end

-------------------------------------------------------------------
-- 버튼 연결
-------------------------------------------------------------------
CreateButton("HK416 지급 [INSTAKILL]", 0, ShootHK416)
CreateButton("서버 골드 지급 시도", 1, EnableRealGold) -- 이름 수정
CreateButton("실시간 ESP [빨강 가깝]", 2, ToggleESP)
CreateButton("바다 제거", 3, function()
    local count = 0
    for _, v in pairs(workspace:GetDescendants()) do 
        if v.Name == "Water" or v:IsA("Terrain") then 
            if v:IsA("Terrain") then v:Clear() else v:Destroy() end
            count += 1
        end 
    end
    print(count .. " 개의 물 제거됨")
end)

print("Daehan Hub v1.2 [HACKED Edition] Loaded!")
print("메뉴 토글 단축키: RightControl")

