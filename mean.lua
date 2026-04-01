--[[ 
    Daehan Hub v1.2 [Legendary Edition] 
    - 통합 업데이트: Raycast(Wallbang), Real-time ESP, NumberValue INF BLOCK
    - 최적화: CFrame.lookAt, hum:TakeDamage 메서드 수정
]]

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")

-------------------------------------------------------------------
-- 1. 로더 GUI (시각적 로딩 효과)
-------------------------------------------------------------------
local loaderGui = Instance.new("ScreenGui", playerGui)
local loadFrame = Instance.new("Frame", loaderGui)
loadFrame.Size = UDim2.new(0, 340, 0, 400); loadFrame.Position = UDim2.new(0.5, 0, 0.5, 0); loadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 20)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1, 0, 0, 50); loadText.Position = UDim2.new(0, 0, 0.6, 0); loadText.Text = "Daehan Hub v1.2 로딩 중..."
loadText.TextColor3 = Color3.fromRGB(255, 255, 255); loadText.Font = "GothamBold"; loadText.TextSize = 20; loadText.BackgroundTransparency = 1

local barBg = Instance.new("Frame", loadFrame)
barBg.Size = UDim2.new(0.8, 0, 0, 10); barBg.Position = UDim2.new(0.1, 0, 0.75, 0); barBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local barFill = Instance.new("Frame", barBg)
barFill.Size = UDim2.new(0, 0, 1, 0); barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 120)

ts:Create(barFill, TweenInfo.new(2, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)}):Play()
task.wait(2.2); loaderGui:Destroy()

-------------------------------------------------------------------
-- 2. 메인 허브 UI (컴퓨터 창 스타일)
-------------------------------------------------------------------
local mainGui = Instance.new("ScreenGui", playerGui)
local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 600, 0, 380); mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0); mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", mainFrame)

-- 사이드바
local sideBar = Instance.new("Frame", mainFrame)
sideBar.Size = UDim2.new(0, 160, 1, 0); sideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local buttons = {}
local function CreateButton(name, pos, callback)
    local btn = Instance.new("TextButton", sideBar)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, 70 + (pos*45))
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.Text = name; btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = "Gotham"; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    buttons[name] = btn
end

-------------------------------------------------------------------
-- 3. 핵심 기능 함수 (최적화 버전)
-------------------------------------------------------------------

-- [기능 1] Raycast HK416 (CFrame.lookAt + TakeDamage 수정)
local function ShootHK416()
    local tool = Instance.new("Tool", player.Backpack); tool.Name = "🔥 HK416 [V1.2]"
    local handle = Instance.new("Part", tool); handle.Name = "Handle"; handle.Size = Vector3.new(0.5, 1, 3.5)
    local mesh = Instance.new("SpecialMesh", handle); mesh.MeshId = "rbxassetid://4701290654"; mesh.Scale = Vector3.new(0.05, 0.05, 0.05)
    
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
        local beam = Instance.new("Part", workspace)
        beam.Anchored = true; beam.CanCollide = false; beam.Material = "Neon"; beam.Color = Color3.fromRGB(255, 255, 0)
        beam.Size = Vector3.new(0.1, 0.1, (startPos - endPos).Magnitude)
        beam.CFrame = CFrame.lookAt(startPos:Lerp(endPos, 0.5), endPos)
        game.Debris:AddItem(beam, 0.05)

        if result and result.Instance then
            local model = result.Instance:FindFirstAncestorOfClass("Model")
            local hum = model and model:FindFirstChild("Humanoid")
            if hum and model ~= player.Character then
                hum:TakeDamage(50) -- 정정된 콜론 호출
            end
        end
    end)
end

-- [기능 2] 실시간 ESP (RenderStepped 적용)
local espEnabled = false
local espCons = {}
local function ToggleESP()
    espEnabled = not espEnabled
    for _, c in pairs(espCons) do c:Disconnect() end; espCons = {}
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Head") then
            if v.Character:FindFirstChild("Daehan_ESP") then v.Character.Daehan_ESP:Destroy() end
            if espEnabled then
                local bg = Instance.new("BillboardGui", v.Character.Head)
                bg.Name = "Daehan_ESP"; bg.Size = UDim2.new(0, 200, 0, 50); bg.AlwaysOnTop = true
                local tl = Instance.new("TextLabel", bg)
                tl.Size = UDim2.new(1, 0, 1, 0); tl.BackgroundTransparency = 1; tl.TextColor3 = Color3.fromRGB(255, 255, 255); tl.Font = "GothamBold"
                
                local con = rs.RenderStepped:Connect(function()
                    if not espEnabled or not v.Character or not v.Character:FindFirstChild("Head") then return end
                    local dist = math.floor((player.Character.Head.Position - v.Character.Head.Position).Magnitude)
                    tl.Text = string.format("%s [%d m]", v.DisplayName, dist)
                end)
                table.insert(espCons, con)
            end
        end
    end
end

-- [기능 3] INF BLOCK (NumberValue 포함)
local function EnableInfBlock()
    local data = player:FindFirstChild("Data") or player:WaitForChild("Data", 5)
    local function freeze(obj)
        if obj:IsA("IntValue") or obj:IsA("Int64Value") or obj:IsA("NumberValue") then
            obj.Value = 999999
            obj.Changed:Connect(function() obj.Value = 999999 end)
        end
    end
    for _, v in pairs(data:GetDescendants()) do freeze(v) end
    data.DescendantAdded:Connect(freeze)
end

-------------------------------------------------------------------
-- 버튼 연결
-------------------------------------------------------------------
CreateButton("HK416 지급", 0, ShootHK416)
CreateButton("INF BLOCK", 1, EnableInfBlock)
CreateButton("실시간 ESP", 2, ToggleESP)
CreateButton("바다 제거", 3, function()
    for _, v in pairs(workspace:GetDescendants()) do if v.Name == "Water" then v:Destroy() end end
end)

print("Daehan Hub v1.2 [Legendary Edition] Loaded!")
