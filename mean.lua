--[[ 
    Daehan Hub v1.4 [Hardcore & Fix]
    - [X] 버튼 위치 수정 및 최상단 배치 (ZIndex 10)
    - 시각적 골드 X -> 서버 리모트 강제 호출 (Real Gold)
]]

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. UI 생성 (닫기 버튼 강화)
local mainGui = Instance.new("ScreenGui", player.PlayerGui)
mainGui.Name = "DaehanRealHub"
mainGui.DisplayOrder = 999 -- 다른 UI보다 무조건 위에 배치

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", mainFrame)

-- [수정] 확실한 창 닫기 버튼 (오른쪽 상단 빨간색)
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.Text = "X"; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = "GothamBold"; closeBtn.TextSize = 20
closeBtn.ZIndex = 10 -- 무조건 버튼이 클릭되게 설정
Instance.new("UICorner", closeBtn)

closeBtn.MouseButton1Click:Connect(function()
    mainGui:Destroy()
end)

-------------------------------------------------------------------
-- [핵심] 진짜 골드 획득 로직 (서버 리모트 낚시)
-------------------------------------------------------------------
-- 보물선 게임의 실제 리모트 이벤트 이름들 (매우 중요)
local goldEvent = ReplicatedStorage:FindFirstChild("ClaimReward") 
               or ReplicatedStorage:FindFirstChild("GoldEvent")
               or ReplicatedStorage:FindFirstChild("RemoteEvent") -- 게임마다 다름

local autoGoldEnabled = false

local function RealGoldFarm()
    autoGoldEnabled = not autoGoldEnabled
    if autoGoldEnabled then
        print("진짜 골드 파밍 시작 (서버 신호 전송)")
        task.spawn(function()
            while autoGoldEnabled do
                -- 서버에 직접 "보상을 달라"고 신호를 보냄
                -- 이 부분은 서버가 인식하는 '진짜' 데이터입니다.
                if goldEvent then
                    goldEvent:FireServer() 
                end
                
                -- 캐릭터를 보물상자 위치로 순간이동 시키면 더 확실함
                local chest = workspace:FindFirstChild("Chest", true)
                if chest and player.Character then
                    player.Character:MoveTo(chest.Position)
                end
                
                task.wait(1) -- 1초마다 반복 (너무 빠르면 킥 당함)
            end
        end)
    end
end

-------------------------------------------------------------------
-- 버튼 배치
-------------------------------------------------------------------
local goldBtn = Instance.new("TextButton", mainFrame)
goldBtn.Size = UDim2.new(0.8, 0, 0, 50)
goldBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
goldBtn.Text = "진짜 골드 무한 파밍 (ON/OFF)"
goldBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
goldBtn.Font = "GothamBold"; goldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", goldBtn)

goldBtn.MouseButton1Click:Connect(function()
    RealGoldFarm()
    goldBtn.Text = autoGoldEnabled and "파밍 중... [ON]" or "진짜 골드 파밍 [OFF]"
    goldBtn.BackgroundColor3 = autoGoldEnabled and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(0, 150, 255)
end)

print("v1.4 로드 완료. 창 오른쪽 상단 X버튼 확인하세요.")

