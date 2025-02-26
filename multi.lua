_1 = "SocialBot001"
_2 = "SocialBot002"

Syntax = "𰻝"


Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
TextChatService = game:GetService("TextChatService")
TextChannel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
RunService = game:GetService("RunService")

if LocalPlayer.Name ~= _1 and LocalPlayer.Name ~= _2 then
	return
end

Timer = 0

RootTarget = nil
RootOffset = Vector3.zero
RootRotation = 0

RunService.Heartbeat:Connect(function()
	LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero

	if RootTarget then do
			LocalPlayer.Character.HumanoidRootPart.CFrame = (CFrame.new(RootTarget.Character.HumanoidRootPart.position) + RootOffset) * CFrame.Angles(0,math.rad(RootRotation),0)
		end
	else
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,-20,0)
	end
end)


function Chatted(Message)
	if string.match(Message, Syntax) then
		local Table = string.split(Message:gsub(Syntax,""),",")
		local Target = Table[1]
		local Timer = tonumber(Table[2])

		RootTarget = Players[Target]
		RootOffset = Vector3.new(0,-20,0)

		while true do
			if tonumber(os.date("%S")) == Timer or tonumber(os.date("%S")) == Timer + 1 then
				--print("TIME")
				break
			end
			--print(Timer,os.date("%S"))
			RunService.Stepped:Wait()
		end

		if LocalPlayer.Name == _1 then
			RootOffset = Vector3.new(5,0,0)
			RootRotation = 90
		end

		if LocalPlayer.Name == _2 then
			RootOffset = Vector3.new(-5,0,0)
			RootRotation = -90
		end

		TextChannel:SendAsync("YOU ARE BEING WATCHED")

		task.wait(3)

		RootOffset = Vector3.new(0,-20,0)

		task.wait(3)

		RootTarget = nil
		RootOffset = Vector3.zero

	end
end

wait(10)

if LocalPlayer.Name == _1 then
	SG = Instance.new("ScreenGui",LocalPlayer.PlayerGui)

	Back = Instance.new("Frame",SG)
	Back.Draggable = true
	Back.Size = UDim2.new(.2,0,.2,0)
	Back.Position = UDim2.new(0,0,1,0)
	Back.AnchorPoint = Vector2.new(0,1)

	TextBox = Instance.new("TextBox",Back)
	TextBox.Size = UDim2.new(1,0,.5,0)
	TextBox.TextScaled = true

	Button = Instance.new("TextButton",Back)
	Button.Size = UDim2.new(1,0,.5,0)
	Button.Position = UDim2.new(0,0,.5,0)
	Button.Text = "Do the thing!!!"
	Button.TextScaled = true

	Button.MouseButton1Up:Connect(function()
		Timer = os.date("%S") + 20
		if Timer > 59 then Timer -= 60 end
		local NM = Syntax..TextBox.Text..","..tostring(Timer)
		TextChannel:SendAsync(NM)
		Chatted(NM)
	end)
end

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	v.Chatted:connect(function(chat)
		Chatted(chat)
	end)
end
