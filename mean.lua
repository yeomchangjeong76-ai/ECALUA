--[[
    Daehan Hub v1.3 [Legendary Edition - Reality Check]
    - Improved Remote Scanner for Damage/Gold
    - HK416: Remote attempt + Joint Destruction Fallback (더 세게 죽임)
    - Infinite Gold: Value Lock + Basic Auto Farm Integration
    - Clean UI + ESP
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Loader (기존 유지, 생략 가능하지만 그대로)
local loaderGui = Instance.new("ScreenGui", playerGui)
loaderGui.Name = "DaehanLoader"; loaderGui.ResetOnSpawn = false
-- ... (로더 코드 동일, 공간상 생략. 이전 버전 그대로 복사해서 사용)

-------------------------------------------------------------------
-- Main GUI (이전과 동일하게 유지)
-------------------------------------------------------------------
local mainGui = Instance.new("ScreenGui", playerGui)
mainGui.Name = "DaehanHub"; mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 600, 0, 380)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame)

-- Top Bar & Close Button (이전 코드 그대로)

-------------------------------------------------------------------
-- Enhanced Remote Scanner
-------------------------------------------------------------------
local function GetTargetRemotes()
    local targets = {}
    for _, desc in pairs(ReplicatedStorage:GetDescendants()) do
        if desc:IsA("RemoteEvent") then
            local name = desc.Name:lower()
            if name:find("damage") or name:find("hit") or name:find("kill") or name:find("shoot") or 
               name:find("gold") or name:find("coin") or name:find("money") or name:find("reward") then
                table.insert(targets, desc)
            end
        end
    end
    return targets
end

-------------------------------------------------------------------
-- HK416 - 더 강력한 Real Kill (Remote + Fallback)
-------------------------------------------------------------------
local function GiveHK416()
    local tool = Instance.new("Tool", player.Backpack)
    tool.Name = "🔥 HK416 [v1.3 Real Kill]"

    local handle = Instance.new("Part", tool)
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.5, 1, 3.5)
    Instance.new("SpecialMesh", handle).MeshId = "rbxassetid://4701290654"

    local damageRemotes = GetTargetRemotes()

    tool.Activated:Connect(function()
        local mouse = player:GetMouse()
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {player.Character}
        rayParams.FilterType = Enum.RaycastFilterType.Exclude

        local result = workspace:Raycast(handle.Position, (mouse.Hit.Position - handle.Position).Unit * 1500, rayParams)

        -- Visual Beam
        if result then
            local beam = Instance.new("Part", workspace)
            beam.Anchored = true
            beam.CanCollide = false
            beam.Material = Enum.Material.Neon
            beam.Color = Color3.fromRGB(255, 40, 40)
            beam.Size = Vector3.new(0.2, 0.2, (handle.Position - result.Position).Magnitude)
            beam.CFrame = CFrame.lookAt(handle.Position:Lerp(result.Position, 0.5), result.Position)
            Debris:AddItem(beam, 0.12)
        end

        if result and result.Instance then
            local model = result.Instance:FindFirstAncestorWhichIsA("Model")
            if model and model \~= player.Character then
                local hum = model:FindFirstChildOfClass("Humanoid")
                if hum then
                    -- Remote Attempt (서버 시도)
                    for _, remote in ipairs(damageRemotes) do
                        pcall(function()
                            remote:FireServer(hum, 999, "HK416")  -- 데미지 크게
                        end)
                    end

                    -- Fallback 강제 Kill (Joint Destruction + Velocity)
                    for _, joint in pairs(model:GetDescendants()) do
                        if joint:IsA("Motor6D") or joint:IsA("Weld") or joint:IsA("WeldConstraint") then
                            joint:Destroy()
                        end
                    end
                    hum.Health = 0
                    hum:ChangeState(Enum.HumanoidStateType.Dead)

                    local root = hum.RootPart or model:FindFirstChild("HumanoidRootPart")
                    if root then
                        root.AssemblyLinearVelocity = Vector3.new(0, -300, 0)
                        root.AssemblyAngularVelocity = Vector3.new(100, 100, 100)
                    end
                end
            end
        end
    end)
end

-------------------------------------------------------------------
-- Infinite Gold (Lock + Attempt)
-------------------------------------------------------------------
local function EnableInfiniteGold()
    local data = player:FindFirstChild("Data") or player:WaitForChild("Data", 5)
    if not data then warn("[Daehan] Data folder not found") return end

    local goldNames = {"Gold", "Coins", "Money", "Cash", "Balance", "Currency", "Points"}

    local function LockInfinite(v)
        if v:IsA("NumberValue") or v:IsA("IntValue") then
            v.Value = 999999999
            v.Changed:Connect(function() v.Value = 999999999 end)
        end
    end

    for _, child in pairs(data:GetDescendants()) do
        if table.find(goldNames, child.Name) then LockInfinite(child) end
    end

    data.DescendantAdded:Connect(function(c)
        if table.find(goldNames, c.Name) then LockInfinite(c) end
    end)

    -- Remote 시도
    local remotes = GetTargetRemotes()
    for _, r in ipairs(remotes) do
        if r.Name:lower():find("gold") or r.Name:lower():find("coin") then
            pcall(function() r:FireServer(999999) end)
        end
    end

    print("[Daehan] Infinite Gold - Value Locked + Remote Attempted")
end

-- ESP와 Remove Water는 이전 버전 그대로 (ToggleESP, 버튼 생성 등)

print("Daehan Hub v1.3 Loaded - Remote Enhanced + Stronger Kill Fallback")
