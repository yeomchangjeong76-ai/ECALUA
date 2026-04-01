--[[ 
    Daehan Hub v1.2 [Legendary Edition] 
    - 통합 업데이트: Raycast(Wallbang), Real-time ESP, NumberValue INF BLOCK
    - 최적화: CFrame.lookAt, hum:TakeDamage 메서드 수정
    - 기능 추가: 창 닫기 버튼(X) 및 단축키(RightControl) 토글
]]

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService") -- [추가] 단축키 감지용

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
loadText.Size = UDim2.new(1, 0, 0, 50); loadText.Position = UDim2.new(0, 0, 0.6, 0); loadText.Text = "Daehan Hub v1.2 로딩 중..."
loadText.TextColor3 = Color3.fromRGB(255, 255, 255); loadText.Font = "GothamBold"; loadText.TextSize = 20; loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.8, 0, 0, 10); barBg.Position = UDim2.new(0.1, 0, 0.75, 0); barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30); barBg.BorderSizePixel = 0
local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 120); barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill)
Instance.new("UICorner", barBg)

ts:Create(barFill, TweenInfo.new(2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(2.2); loaderGui:Destroy()

-------------------------------------------------------------------
-- 2. 메인 허브 UI (컴퓨터 창 스타일)
-------------------------------------------------------------------
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "DaehanHub_v1.2"
mainGui.ResetOnSpawn = false
mainGui.Enabled = true -- 초기 상태: 켜짐

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 600, 0, 380); mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0); mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); mainFrame.BorderSizePixel = 0
mainFrame.Active = true; mainFrame.Draggable = true -- [추가] 창 드래그 가능하게
Instance.new("UICorner", mainFrame)

-- [새로 추가] 상단 타이틀 바 & 닫기 버튼 영역
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 30); topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); topBar.BorderSizePixel = 0
local topCorner = Instance.new("UICorner", topBar); topCorner.CornerRadius = UDim.new(0, 8)
-- 아래쪽 코너만 각지게 만들기 위한 눈속임용 프레임
local bottomFix = Instance.new("Frame", topBar)
bottomFix.Size = UDim2.new(1, 0, 0.5, 0); bottomFix.Position = UDim2.new(0, 0, 0.5, 0); bottomFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25); bottomFix.BorderSizePixel = 0

local titleText = Instance.new("TextLabel", topBar)
titleText.Size = UDim2.new(0, 200, 1, 0); titleText.Position = UDim2.new(0, 10, 0, 0); titleText.Text = "Daehan Hub v1.2 - Legendary"
titleText.TextColor3 = Color3.fromRGB(200, 200, 200); titleText.Font = "GothamBold"; titleText.TextSize = 14; titleText.TextXAlignment = "Left"; titleText.BackgroundTransparency = 1

-- [핵심 추가] 창 닫기 버튼 (X)
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -27, 0.5, 0); closeBtn.AnchorPoint = Vector2.new(0, 0.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); closeBtn.BorderSizePixel = 0
closeBtn.Text = "×" -- 곱하기 기호가 X보다 깔끔함
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); closeBtn.Font = "GothamBold"; closeBtn.TextSize = 20
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

-- 닫기 버튼 기능
closeBtn.MouseButton1Click:Connect(function()
    mainGui.Enabled = false
    print("Daehan Hub 닫힘 (다시 켜려면 RightControl 키)")
end)

-- [핵심 추가] 단축키로 끄고 켜기 (RightControl)
uis.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        mainGui.Enabled = not mainGui.Enabled
    end
end)

-- 사이드바 (위치 수정: topBar 아래로)
local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 160, 1, -30); sideBar.Position = UDim2.new(0, 0, 0, 30)
sideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); sideBar.BorderSizePixel = 0

-- 로고/제목 (사이드바 내부)
local logoLabel = Instance.new("TextLabel", sideBar)
logoLabel.Size = UDim2.new(1, 0, 0, 60); logoLabel.Position = UDim2.new(0, 0, 0, 0)
logoLabel.Text = "DAEHAN"; logoLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
logoLabel.Font = "GothamBlack"; logoLabel.TextSize = 28; logoLabel.BackgroundTransparency = 1

-- 버튼 컨테이너 (스크롤 가능하게 원하면 scrollingframe 사용, 여기선 그냥 frame)
local buttonFrame = Instance.new("Frame", sideBar)
buttonFrame.Size = UDim2.new(1, 0, 1, -70); buttonFrame.Position = UDim2.new(0, 0, 0, 70); buttonFrame.BackgroundTransparency = 1

local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", buttonFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, (pos*45))
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.BorderSizePixel = 0
    btn.Text = name; btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = "GothamMedium"; btn.TextSize = 14
    Instance.new("UICorner", btn)
    
    -- 호버 효과
    btn.MouseEnter:Connect(function() ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play() end)
    btn.MouseLeave:Connect(function() ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play() end)
    
    btn.MouseButton1Click:Connect(callback)
end

-------------------------------------------------------------------
-- 3. 핵심 기능 함수 (기존 내용 유지)
-------------------------------------------------------------------

-- [기능 1] Raycast HK416 (CFrame.lookAt + TakeDamage 수정)
local function ShootHK416()
    local tool = Instance.new("Tool"); tool.Name = "🔥 HK416 [V1.2]"; tool.Parent = player.Backpack
    local handle = Instance.new("Part"); handle.Name = "Handle"; handle.Size = Vector3.new(0.5, 1, 3.5); handle.Parent = tool
    local mesh = Instance.new("SpecialMesh"); mesh.MeshId = "rbxassetid://4701290654"; mesh.Scale = Vector3.new(0.05, 0.05, 0.05); mesh.Parent = handle
    
    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local startPos = handle.Position
        local targetPos = mouse.Hit.p
        local direction = (targetPos - startPos).Unit
        
        local rayparams = RaycastParams.new()
        rayparams.FilterType = Enum.RaycastFilterType.Exclude
        rayparams.FilterDescendantsInstances = {player.Character, tool}

        local result = workspace:Raycast(startPos, direction * 1000, rayparams)
        local endPos = result and result.Position or (startPos + direction * 1000)

        -- 궤적 생성 (lookAt 적용)
        local beam = Instance.new("Part")
        beam.Anchored = true; beam.CanCollide = false; beam.Material = Enum.Material.Neon; beam.Color = Color3.fromRGB(255, 255, 0)
        beam.Size = Vector3.new(0.1, 0.1, (startPos - endPos).Magnitude)
        beam.CFrame = CFrame.lookAt(startPos:Lerp(endPos, 0.5), endPos)
        beam.Parent = workspace
        game.Debris:AddItem(beam, 0.05)

        if result and result.Instance then
            local model = result.Instance:FindFirstAncestorOfClass("Model")
            local hum = model and model:FindFirstChild("Humanoid")
            if hum and model ~= player.Character then
                hum:TakeDamage(50) -- 정정된 콜론 호출
            end
        end
    end)
    print("HK416 지급 완료")
end

-- [기능 2] 실시간 ESP (RenderStepped 적용)
local espEnabled = false
local espCons = {}
local function ToggleESP()
    espEnabled = not espEnabled
    print("ESP 상태: ", espEnabled)
    
    for _, c in pairs(espCons) do c:Disconnect() end; espCons = {}
    
    -- 기존 ESP 정리
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
                    local bg = Instance.new("BillboardGui", head)
                    bg.Name = "Daehan_ESP"; bg.Size = UDim2.new(0, 200, 0, 50); bg.AlwaysOnTop = true
                    local tl = Instance.new("TextLabel", bg)
                    tl.Size = UDim2.new(1, 0, 1, 0); tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.fromRGB(255, 255, 255); tl.Font = "GothamBold"; tl.TextSize = 12
                    
                    local con = rs.RenderStepped:Connect(function()
                        if not espEnabled or not v.Character or not v.Character:FindFirstChild("Head") then 
                            tl.Text = ""; return 
                        end
                        local dist = math.floor((player.Character.Head.Position - v.Character.Head.Position).Magnitude)
                        tl.Text = string.format("%s [%d m]", v.DisplayName, dist)
                        -- 거리별 색상 변경 (가까우면 빨강, 멀면 초록)
                        if dist < 50 then tl.TextColor3 = Color3.fromRGB(255, 50, 50)
                        elseif dist < 100 then tl.TextColor3 = Color3.fromRGB(255, 255, 50)
                        else tl.TextColor3 = Color3.fromRGB(50, 255, 50) end
                    end)
                    table.insert(espCons, con)
                end
            end)
            -- 현재 존재하는 캐릭터에 적용
            if v.Character and v.Character:FindFirstChild("Head") then
                local head = v.Character.Head
                if head:FindFirstChild("Daehan_ESP") then head.Daehan_ESP:Destroy() end
                
                local bg = Instance.new("BillboardGui", head)
                bg.Name = "Daehan_ESP"; bg.Size = UDim2.new(0, 200, 0, 50); bg.AlwaysOnTop = true
                local tl = Instance.new("TextLabel", bg)
                tl.Size = UDim2.new(1, 0, 1, 0); tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.fromRGB(255, 255, 255); tl.Font = "GothamBold"; tl.TextSize = 12
                
                local con = rs.RenderStepped:Connect(function()
                    if not espEnabled or not v.Character or not v.Character:FindFirstChild("Head") then return end
                    if not player.Character or not player.Character:FindFirstChild("Head") then return end
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
        -- [최적화] 새로 들어온 플레이어도 자동 적용
        local joinCon = game.Players.PlayerAdded:Connect(addESP)
        table.insert(espCons, joinCon)
    end
end

-- [기능 3] INF BLOCK (NumberValue 포함)
local function EnableInfBlock()
    local data = player:FindFirstChild("Data") or player:WaitForChild("Data", 5)
    if not data then print("Data 폴더를 찾을 수 없습니다."); return end
    
    local function freeze(obj)
        if obj:IsA("IntValue") or obj:IsA("Int64Value") or obj:IsA("NumberValue") then
            obj.Value = 9999999 -- 값 살짝 늘림
            obj.Changed:Connect(function() obj.Value = 9999999 end)
        end
    end
    for _, v in pairs(data:GetDescendants()) do freeze(v) end
    data.DescendantAdded:Connect(freeze)
    print("INF BLOCK 적용 완료")
end

-------------------------------------------------------------------
-- 버튼 연결
-------------------------------------------------------------------
CreateButton("HK416 지급", 0, ShootHK416)
CreateButton("INF BLOCK", 1, EnableInfBlock)
CreateButton("실시간 ESP", 2, ToggleESP)
CreateButton("바다 제거", 3, function()
    local count = 0
    for _, v in pairs(workspace:GetDescendants()) do 
        if v.Name == "Water" or v:IsA("Terrain") then -- Terrain 물 포함
            if v:IsA("Terrain") then v:Clear() 
            else v:Destroy() end
            count += 1
        end 
    end
    print(count .. " 개의 물 요소 제거됨")
end)

print("Daehan Hub v1.2 [Legendary Edition] Loaded!")
print("메뉴 토글 단축키: RightControl")

