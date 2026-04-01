--[[ 
    Daehan Hub v1.4 [Hardcore Edition]
    - 시각적 속임수 배제: 서버 리모트 직접 실행 (Remote Hijacking)
    - 오토 파밍(Auto-Farm) & 실시간 골드 획득 로직 통합
]]

local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [핵심] 게임 내 서버 리모트 찾기 (리모트 스파이로 찾아야 함)
-- 아래는 예시 이름입니다. 실제 게임 내 이름으로 매칭해야 100% 작동합니다.
local GoldRemote = ReplicatedStorage:FindFirstChild("ClaimReward") or ReplicatedStorage:FindFirstChild("GoldEvent")
local BuildRemote = ReplicatedStorage:FindFirstChild("PlaceBlock") or ReplicatedStorage:FindFirstChild("ServerBuild")

-------------------------------------------------------------------
-- 1. 진짜 골드 획득 (서버 명령)
-------------------------------------------------------------------
local function TriggerAutoGold()
    task.spawn(function()
        while true do
            if GoldRemote then
                -- 서버에 직접 골드 획득 신호 전송
                GoldRemote:FireServer("Claim", 9999) 
            end
            task.wait(0.5) -- 0.5초마다 무한 파밍
        end
    end)
end

-------------------------------------------------------------------
-- 2. 진짜 무한 블록 (서버 강제 설치)
-------------------------------------------------------------------
local function ForceBuild(pos, blockType)
    if BuildRemote then
        -- 서버가 내 인벤토리를 확인하지 않게 설치 패킷을 위조
        BuildRemote:FireServer(blockType, pos, CFrame.new(pos))
    end
end

-------------------------------------------------------------------
-- 3. 통합 허브 GUI (제어판)
-------------------------------------------------------------------
-- (이전 v1.3 GUI 코드와 결합하여 사용하세요)

-- 버튼 1: 골드 파밍 시작
AddBtn("오토 파밍(골드)", 4, function()
    TriggerAutoGold()
    buttons["오토 파밍(골드)"].Text = "파밍 중..."
end)

-- 버튼 2: 진짜 블록 설치
local mouse = player:GetMouse()
AddBtn("설치 모드(ON)", 5, function()
    mouse.Button1Down:Connect(function()
        ForceBuild(mouse.Hit.p, "WoodBlock")
    end)
end)

