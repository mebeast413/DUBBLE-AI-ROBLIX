local HttpService=game:GetService("HttpService")
local UserInputService=game:GetService("UserInputService")
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer
local gui=Instance.new("ScreenGui")
gui.Name="DubbleAI"
gui.ResetOnSpawn=false
gui.DisplayOrder=999
gui.Parent=player:WaitForChild("PlayerGui")
local knowledge={
{k={"привет","прив","хай","здарова","ку"},a="Привет! Чем помочь?"},
{k={"как дела","как ты"},a="Всё отлично! А у тебя как?"},
{k={"что делаешь"},a="Помогаю тебе! Задай вопрос."},
{k={"кто ты","что ты"},a="Я DUBBLE AI — помощник в Roblox."},
{k={"что умеешь"},a="Отвечаю на вопросы, помогаю с кодом."},
{k={"спасибо","благодарю"},a="Пожалуйста!"},
{k={"пока","бай"},a="Пока! Удачи."},
{k={"анти флинг","antifling"},a="Напиши ANTI FLING в чат."},
{k={"ноклип","noclip"},a="Напиши NOCLIP в чат."},
{k={"радио","radio"},a="Напиши RADIO в чат."},
{k={"да","ок"},a="Принято!"},
{k={"нет"},a="Понял."}}
local songs={
{id="754859317667123",name="Священная война"},
{id="18982131020",name="Лето и арбалеты"},
{id="90398320838813",name="Я закричу на весь мир"},
{id="9040163991",name="Гимн России"},
{id="101241740024903",name="Tripi Tropi Tropa Tripa Phonk"},
{id="132973772452511",name="Москва"},
{id="122925258674975",name="Я сошла с ума"},
{id="15689441943",name="All Back"},
{id="133101411205559",name="Мио Море"},
{id="73180347730720",name="Нас не догонят"},
{id="128027817703253",name="Юность в сапогах"},
{id="119066634941346",name="Ты меня не ищи"},
{id="95632852758777",name="Верните в моду любовь"},
{id="106619031644220",name="Неистовый свет"},
{id="102172300933284",name="Мориарти (madkld)"}}
local openBtn=Instance.new("TextButton")
openBtn.Size=UDim2.new(0,220,0,50)
openBtn.Position=UDim2.new(0.5,-110,0,10)
openBtn.BackgroundColor3=Color3.fromRGB(15,15,22)
openBtn.BackgroundTransparency=0.4
openBtn.Text=""
openBtn.BorderSizePixel=0
openBtn.AutoButtonColor=false
openBtn.Parent=gui
local openCorner=Instance.new("UICorner")
openCorner.CornerRadius=UDim.new(1,0)
openCorner.Parent=openBtn
local openStroke=Instance.new("UIStroke")
openStroke.Color=Color3.fromRGB(100,180,255)
openStroke.Thickness=1.5
openStroke.Transparency=0.4
openStroke.Parent=openBtn
local openLabel=Instance.new("TextLabel")
openLabel.Size=UDim2.new(1,0,1,0)
openLabel.BackgroundTransparency=1
openLabel.Text="👾  DUBBLE AI  👾"
openLabel.TextColor3=Color3.fromRGB(180,210,255)
openLabel.Font=Enum.Font.GothamBold
openLabel.TextSize=18
openLabel.TextXAlignment=Enum.TextXAlignment.Center
openLabel.TextYAlignment=Enum.TextYAlignment.Center
openLabel.Parent=openBtn
task.spawn(function()
local t=0
while openLabel.Parent do
t=t+0.05
local r=180+math.sin(t)*50
local g=210+math.sin(t+1)*30
openLabel.TextColor3=Color3.fromRGB(r,g,255)
task.wait(0.05)
end
end)
local draggingBtn=false
local dragBtnStart,dragBtnPos
local movedBtn=false
openBtn.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
draggingBtn=true
movedBtn=false
dragBtnStart=input.Position
dragBtnPos=openBtn.Position
end
end)
openBtn.InputChanged:Connect(function(input)
if draggingBtn and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
local delta=input.Position-dragBtnStart
if math.abs(delta.X)>4 or math.abs(delta.Y)>4 then movedBtn=true end
openBtn.Position=UDim2.new(dragBtnPos.X.Scale,dragBtnPos.X.Offset+delta.X,dragBtnPos.Y.Scale,dragBtnPos.Y.Offset+delta.Y)
end
end)
openBtn.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
draggingBtn=false
end
end)
local mainFrame=Instance.new("Frame")
mainFrame.Size=UDim2.new(0,0,0,0)
mainFrame.Position=UDim2.new(0.5,0,0.5,0)
mainFrame.AnchorPoint=Vector2.new(0.5,0.5)
mainFrame.BackgroundColor3=Color3.fromRGB(18,18,24)
mainFrame.BorderSizePixel=0
mainFrame.ClipsDescendants=true
mainFrame.Visible=false
mainFrame.Active=true
mainFrame.Draggable=true
mainFrame.Parent=gui
local mainCorner=Instance.new("UICorner")
mainCorner.CornerRadius=UDim.new(0,18)
mainCorner.Parent=mainFrame
local mainStroke=Instance.new("UIStroke")
mainStroke.Color=Color3.fromRGB(50,60,85)
mainStroke.Thickness=1.5
mainStroke.Transparency=0.3
mainStroke.Parent=mainFrame
local header=Instance.new("TextLabel")
header.Size=UDim2.new(1,0,0,44)
header.BackgroundTransparency=1
header.Text="👾  DUBBLE AI  👾"
header.TextColor3=Color3.fromRGB(220,230,255)
header.Font=Enum.Font.GothamBold
header.TextSize=18
header.Parent=mainFrame
local headerLine=Instance.new("Frame")
headerLine.Size=UDim2.new(0.92,0,0,1)
headerLine.Position=UDim2.new(0.04,0,0,44)
headerLine.BackgroundColor3=Color3.fromRGB(50,60,85)
headerLine.BackgroundTransparency=0.4
headerLine.BorderSizePixel=0
headerLine.Parent=mainFrame
local closeBtn=Instance.new("TextButton")
closeBtn.Size=UDim2.new(0,32,0,32)
closeBtn.Position=UDim2.new(1,-38,0,6)
closeBtn.BackgroundTransparency=1
closeBtn.Text="✖️"
closeBtn.TextColor3=Color3.fromRGB(255,100,100)
closeBtn.TextSize=18
closeBtn.Font=Enum.Font.GothamBold
closeBtn.BorderSizePixel=0
closeBtn.Parent=mainFrame
local chatScroll=Instance.new("ScrollingFrame")
chatScroll.Size=UDim2.new(1,-20,1,-150)
chatScroll.Position=UDim2.new(0,10,0,52)
chatScroll.BackgroundColor3=Color3.fromRGB(12,12,18)
chatScroll.BorderSizePixel=0
chatScroll.CanvasSize=UDim2.new(0,0,0,0)
chatScroll.ScrollBarThickness=6
chatScroll.ScrollBarImageColor3=Color3.fromRGB(80,120,200)
chatScroll.ScrollingDirection=Enum.ScrollingDirection.Y
chatScroll.ElasticBehavior=Enum.ElasticBehavior.Never
chatScroll.Parent=mainFrame
local chatCorner=Instance.new("UICorner")
chatCorner.CornerRadius=UDim.new(0,12)
chatCorner.Parent=chatScroll
local chatLayout=Instance.new("UIListLayout")
chatLayout.Padding=UDim.new(0,8)
chatLayout.SortOrder=Enum.SortOrder.LayoutOrder
chatLayout.Parent=chatScroll
local chatPadding=Instance.new("UIPadding")
chatPadding.PaddingTop=UDim.new(0,10)
chatPadding.PaddingLeft=UDim.new(0,10)
chatPadding.PaddingRight=UDim.new(0,10)
chatPadding.PaddingBottom=UDim.new(0,10)
chatPadding.Parent=chatScroll
local inputBtn=Instance.new("TextButton")
inputBtn.Size=UDim2.new(1,-20,0,46)
inputBtn.Position=UDim2.new(0,10,1,-56)
inputBtn.BackgroundColor3=Color3.fromRGB(28,30,42)
inputBtn.Text="напишите запрос..."
inputBtn.TextColor3=Color3.fromRGB(120,130,160)
inputBtn.TextSize=14
inputBtn.Font=Enum.Font.Gotham
inputBtn.BorderSizePixel=0
inputBtn.TextXAlignment=Enum.TextXAlignment.Left
inputBtn.Parent=mainFrame
local inputCorner=Instance.new("UICorner")
inputCorner.CornerRadius=UDim.new(1,0)
inputCorner.Parent=inputBtn
local inputPad=Instance.new("UIPadding")
inputPad.PaddingLeft=UDim.new(0,25)
inputPad.Parent=inputBtn
local inputBox=Instance.new("TextBox")
inputBox.Size=UDim2.new(1,-20,0,46)
inputBox.Position=UDim2.new(0,10,1,-56)
inputBox.BackgroundColor3=Color3.fromRGB(28,30,42)
inputBox.Text=""
inputBox.PlaceholderText="напишите запрос..."
inputBox.PlaceholderColor3=Color3.fromRGB(120,130,160)
inputBox.TextColor3=Color3.fromRGB(230,230,250)
inputBox.TextSize=14
inputBox.Font=Enum.Font.Gotham
inputBox.BorderSizePixel=0
inputBox.ClearTextOnFocus=false
inputBox.TextXAlignment=Enum.TextXAlignment.Left
inputBox.Visible=false
inputBox.Parent=mainFrame
local inputBoxCorner=Instance.new("UICorner")
inputBoxCorner.CornerRadius=UDim.new(1,0)
inputBoxCorner.Parent=inputBox
local inputBoxPad=Instance.new("UIPadding")
inputBoxPad.PaddingLeft=UDim.new(0,25)
inputBoxPad.PaddingRight=UDim.new(0,25)
inputBoxPad.Parent=inputBox
local commandsFrame=Instance.new("Frame")
commandsFrame.Size=UDim2.new(1,0,1,0)
commandsFrame.Position=UDim2.new(0,0,0,52)
commandsFrame.BackgroundTransparency=1
commandsFrame.Parent=mainFrame
local cmdTitle=Instance.new("TextLabel")
cmdTitle.Size=UDim2.new(1,-20,0,20)
cmdTitle.Position=UDim2.new(0,10,0,10)
cmdTitle.BackgroundTransparency=1
cmdTitle.Text="КОМАНДЫ (напиши в чат):"
cmdTitle.TextColor3=Color3.fromRGB(200,220,255)
cmdTitle.Font=Enum.Font.GothamBold
cmdTitle.TextSize=12
cmdTitle.TextXAlignment=Enum.TextXAlignment.Left
cmdTitle.Parent=commandsFrame
local cmdList={
{name="ANTI FLING",desc="откл. колизию врагов",color=Color3.fromRGB(255,100,100)},
{name="NOCLIP",desc="проход сквозь стены",color=Color3.fromRGB(100,255,150)},
{name="RADIO",desc="радио с музыкой",color=Color3.fromRGB(255,200,100)}}
for i,cmd in ipairs(cmdList) do
local box=Instance.new("Frame")
box.Size=UDim2.new(1,-20,0,30)
box.Position=UDim2.new(0,10,0,45+(i-1)*35)
box.BackgroundColor3=Color3.fromRGB(28,30,42)
box.BackgroundTransparency=0.2
box.BorderSizePixel=0
box.Parent=commandsFrame
local boxCorner=Instance.new("UICorner")
boxCorner.CornerRadius=UDim.new(0,8)
boxCorner.Parent=box
local boxStroke=Instance.new("UIStroke")
boxStroke.Color=cmd.color
boxStroke.Thickness=1
boxStroke.Transparency=0.5
boxStroke.Parent=box
local nameLbl=Instance.new("TextLabel")
nameLbl.Size=UDim2.new(0.45,0,1,0)
nameLbl.Position=UDim2.new(0,10,0,0)
nameLbl.BackgroundTransparency=1
nameLbl.Text=cmd.name
nameLbl.TextColor3=cmd.color
nameLbl.Font=Enum.Font.GothamBold
nameLbl.TextSize=13
nameLbl.TextXAlignment=Enum.TextXAlignment.Left
nameLbl.Parent=box
local descLbl=Instance.new("TextLabel")
descLbl.Size=UDim2.new(0.5,0,1,0)
descLbl.Position=UDim2.new(0.5,0,0,0)
descLbl.BackgroundTransparency=1
descLbl.Text=cmd.desc
descLbl.TextColor3=Color3.fromRGB(150,160,190)
descLbl.Font=Enum.Font.Gotham
descLbl.TextSize=11
descLbl.TextXAlignment=Enum.TextXAlignment.Right
descLbl.Parent=box
end
local hasWritten=false
local thinkingLabel=nil
local antiFlingActive=false
local noclipActive=false
local function addMessage(text,isUser,customColor)
if isUser then hasWritten=true end
local lbl=Instance.new("TextLabel")
lbl.Size=UDim2.new(1,-20,0,0)
lbl.AutomaticSize=Enum.AutomaticSize.Y
lbl.BackgroundTransparency=1
if isUser then
lbl.Text="Ты: "..text
lbl.TextColor3=Color3.fromRGB(140,190,255)
else
lbl.Text=customColor and text or ("DUBBLE AI: "..text)
lbl.TextColor3=customColor or Color3.fromRGB(200,230,200)
end
lbl.Font=Enum.Font.Gotham
lbl.TextSize=13
lbl.TextWrapped=true
lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.TextYAlignment=Enum.TextYAlignment.Top
lbl.Parent=chatScroll
if commandsFrame.Visible then commandsFrame.Visible=false end
task.wait(0.05)
local totalHeight=chatLayout.AbsoluteContentSize.Y+30
chatScroll.CanvasSize=UDim2.new(0,0,0,totalHeight)
local isAtBottom=(chatScroll.CanvasPosition.Y+chatScroll.AbsoluteSize.Y)>=(totalHeight-40)
if isAtBottom or isUser then
TweenService:Create(chatScroll,TweenInfo.new(0.2),{CanvasPosition=Vector2.new(0,math.max(0,totalHeight-chatScroll.AbsoluteSize.Y))}):Play()
end
end
local function showThinking()
if thinkingLabel then return end
thinkingLabel=Instance.new("TextLabel")
thinkingLabel.Size=UDim2.new(1,-20,0,0)
thinkingLabel.AutomaticSize=Enum.AutomaticSize.Y
thinkingLabel.BackgroundTransparency=1
thinkingLabel.Text="Подожди, Нейросеть думает..."
thinkingLabel.TextColor3=Color3.fromRGB(255,200,100)
thinkingLabel.Font=Enum.Font.Gotham
thinkingLabel.TextSize=13
thinkingLabel.TextWrapped=true
thinkingLabel.TextXAlignment=Enum.TextXAlignment.Left
thinkingLabel.Parent=chatScroll
task.wait(0.05)
local totalHeight=chatLayout.AbsoluteContentSize.Y+30
chatScroll.CanvasSize=UDim2.new(0,0,0,totalHeight)
TweenService:Create(chatScroll,TweenInfo.new(0.2),{CanvasPosition=Vector2.new(0,math.max(0,totalHeight-chatScroll.AbsoluteSize.Y))}):Play()
end
local function hideThinking()
if thinkingLabel then thinkingLabel:Destroy() thinkingLabel=nil end
end
local function findLocalAnswer(text)
local lower=text:lower():gsub("[%p]","")
if #lower>30 then return nil end
for _,item in ipairs(knowledge) do
for _,key in ipairs(item.k) do
if lower==key then return item.a end
end
end
return nil
end
local antiFlingData={}
local antiFlingConn=nil
local function enableAntiFling()
if antiFlingActive then return end
antiFlingActive=true
for _,v in ipairs(Players:GetPlayers()) do
if v~=player and v.Character then
if not antiFlingData[v] then antiFlingData[v]={} end
for _,part in ipairs(v.Character:GetDescendants()) do
if part:IsA("BasePart") then
if antiFlingData[v][part]==nil then antiFlingData[v][part]=part.CanCollide end
part.CanCollide=false
end
end
end
end
antiFlingConn=RunService.Heartbeat:Connect(function()
if not antiFlingActive then return end
for _,v in ipairs(Players:GetPlayers()) do
if v~=player and v.Character then
for _,part in ipairs(v.Character:GetDescendants()) do
if part:IsA("BasePart") then part.CanCollide=false end
end
end
end
end)
end
local noclipConn=nil
local function enableNoclip()
if noclipActive then return end
noclipActive=true
noclipConn=RunService.Stepped:Connect(function()
if not noclipActive then return end
local char=player.Character
if not char then return end
for _,p in ipairs(char:GetDescendants()) do
if p:IsA("BasePart") then p.CanCollide=false end
end
end)
end
local radioGui=nil
local function openRadio()
if radioGui then return end
radioGui=Instance.new("ScreenGui")
radioGui.Name="DubbleRadio"
radioGui.ResetOnSpawn=false
radioGui.DisplayOrder=1000
radioGui.Parent=player:WaitForChild("PlayerGui")
local radioFrame=Instance.new("Frame")
radioFrame.Size=UDim2.new(0,520,0,400)
radioFrame.Position=UDim2.new(0.5,-260,0.5,-200)
radioFrame.BackgroundColor3=Color3.fromRGB(18,18,24)
radioFrame.BorderSizePixel=0
radioFrame.Active=true
radioFrame.Draggable=true
radioFrame.Parent=radioGui
local rCorner=Instance.new("UICorner")
rCorner.CornerRadius=UDim.new(0,18)
rCorner.Parent=radioFrame
local rStroke=Instance.new("UIStroke")
rStroke.Color=Color3.fromRGB(255,200,100)
rStroke.Thickness=1.5
rStroke.Transparency=0.3
rStroke.Parent=radioFrame
local rHeader=Instance.new("TextLabel")
rHeader.Size=UDim2.new(1,0,0,40)
rHeader.BackgroundTransparency=1
rHeader.Text="📻 RADIO"
rHeader.TextColor3=Color3.fromRGB(255,200,100)
rHeader.Font=Enum.Font.GothamBold
rHeader.TextSize=18
rHeader.Parent=radioFrame
local rClose=Instance.new("TextButton")
rClose.Size=UDim2.new(0,30,0,30)
rClose.Position=UDim2.new(1,-36,0,6)
rClose.BackgroundTransparency=1
rClose.Text="✖️"
rClose.TextColor3=Color3.fromRGB(255,100,100)
rClose.TextSize=16
rClose.Font=Enum.Font.GothamBold
rClose.BorderSizePixel=0
rClose.Parent=radioFrame
local rLine=Instance.new("Frame")
rLine.Size=UDim2.new(0.92,0,0,1)
rLine.Position=UDim2.new(0.04,0,0,40)
rLine.BackgroundColor3=Color3.fromRGB(50,60,85)
rLine.BackgroundTransparency=0.4
rLine.BorderSizePixel=0
rLine.Parent=radioFrame
local idLbl=Instance.new("TextLabel")
idLbl.Size=UDim2.new(0.5,-15,0,20)
idLbl.Position=UDim2.new(0,10,0,50)
idLbl.BackgroundTransparency=1
idLbl.Text="ID музыки:"
idLbl.TextColor3=Color3.fromRGB(180,190,220)
idLbl.Font=Enum.Font.Gotham
idLbl.TextSize=13
idLbl.TextXAlignment=Enum.TextXAlignment.Left
idLbl.Parent=radioFrame
local idBox=Instance.new("TextBox")
idBox.Size=UDim2.new(0.5,-15,0,40)
idBox.Position=UDim2.new(0,10,0,75)
idBox.BackgroundColor3=Color3.fromRGB(28,30,42)
idBox.BorderSizePixel=0
idBox.Text=""
idBox.PlaceholderText="Введи ID..."
idBox.PlaceholderColor3=Color3.fromRGB(120,130,160)
idBox.TextColor3=Color3.fromRGB(230,230,250)
idBox.Font=Enum.Font.Gotham
idBox.TextSize=14
idBox.ClearTextOnFocus=false
idBox.Parent=radioFrame
local idCorner=Instance.new("UICorner")
idCorner.CornerRadius=UDim.new(0,10)
idCorner.Parent=idBox
local volLbl=Instance.new("TextLabel")
volLbl.Size=UDim2.new(0.5,-15,0,20)
volLbl.Position=UDim2.new(0,10,0,125)
volLbl.BackgroundTransparency=1
volLbl.Text="Громкость: 100%"
volLbl.TextColor3=Color3.fromRGB(180,190,220)
volLbl.Font=Enum.Font.Gotham
volLbl.TextSize=13
volLbl.TextXAlignment=Enum.TextXAlignment.Left
volLbl.Parent=radioFrame
local volBar=Instance.new("Frame")
volBar.Size=UDim2.new(0.5,-15,0,6)
volBar.Position=UDim2.new(0,10,0,150)
volBar.BackgroundColor3=Color3.fromRGB(35,38,52)
volBar.BorderSizePixel=0
volBar.Parent=radioFrame
local volBarCorner=Instance.new("UICorner")
volBarCorner.CornerRadius=UDim.new(1,0)
volBarCorner.Parent=volBar
local volFill=Instance.new("Frame")
volFill.Size=UDim2.new(1,0,1,0)
volFill.BackgroundColor3=Color3.fromRGB(255,200,100)
volFill.BorderSizePixel=0
volFill.Parent=volBar
local volFillCorner=Instance.new("UICorner")
volFillCorner.CornerRadius=UDim.new(1,0)
volFillCorner.Parent=volFill
local volKnob=Instance.new("TextButton")
volKnob.Size=UDim2.new(0,16,0,16)
volKnob.Position=UDim2.new(1,-8,0.5,-8)
volKnob.BackgroundColor3=Color3.fromRGB(255,220,150)
volKnob.BorderSizePixel=0
volKnob.Text=""
volKnob.Parent=volBar
local volKnobCorner=Instance.new("UICorner")
volKnobCorner.CornerRadius=UDim.new(1,0)
volKnobCorner.Parent=volKnob
local playBtn=Instance.new("TextButton")
playBtn.Size=UDim2.new(0.24,0,0,40)
playBtn.Position=UDim2.new(0,10,1,-50)
playBtn.BackgroundColor3=Color3.fromRGB(50,180,90)
playBtn.BorderSizePixel=0
playBtn.Text="▶ СТАРТ"
playBtn.TextColor3=Color3.fromRGB(255,255,255)
playBtn.Font=Enum.Font.GothamBold
playBtn.TextSize=13
playBtn.Parent=radioFrame
local playCorner=Instance.new("UICorner")
playCorner.CornerRadius=UDim.new(0,10)
playCorner.Parent=playBtn
local stopBtn=Instance.new("TextButton")
stopBtn.Size=UDim2.new(0.24,0,0,40)
stopBtn.Position=UDim2.new(0.26,0,1,-50)
stopBtn.BackgroundColor3=Color3.fromRGB(200,60,60)
stopBtn.BorderSizePixel=0
stopBtn.Text="■ СТОП"
stopBtn.TextColor3=Color3.fromRGB(255,255,255)
stopBtn.Font=Enum.Font.GothamBold
stopBtn.TextSize=13
stopBtn.Parent=radioFrame
local stopCorner=Instance.new("UICorner")
stopCorner.CornerRadius=UDim.new(0,10)
stopCorner.Parent=stopBtn
local songsLbl=Instance.new("TextLabel")
songsLbl.Size=UDim2.new(0.5,-15,0,20)
songsLbl.Position=UDim2.new(0.5,5,0,50)
songsLbl.BackgroundTransparency=1
songsLbl.Text="СПИСОК ПЕСЕН:"
songsLbl.TextColor3=Color3.fromRGB(180,190,220)
songsLbl.Font=Enum.Font.GothamBold
songsLbl.TextSize=11
songsLbl.TextXAlignment=Enum.TextXAlignment.Left
songsLbl.Parent=radioFrame
local songsScroll=Instance.new("ScrollingFrame")
songsScroll.Size=UDim2.new(0.5,-15,1,-140)
songsScroll.Position=UDim2.new(0.5,5,0,75)
songsScroll.BackgroundColor3=Color3.fromRGB(12,12,18)
songsScroll.BorderSizePixel=0
songsScroll.CanvasSize=UDim2.new(0,0,0,0)
songsScroll.ScrollBarThickness=4
songsScroll.ScrollBarImageColor3=Color3.fromRGB(80,120,200)
songsScroll.Parent=radioFrame
local songsCorner=Instance.new("UICorner")
songsCorner.CornerRadius=UDim.new(0,10)
songsCorner.Parent=songsScroll
local songsLayout=Instance.new("UIListLayout")
songsLayout.Padding=UDim.new(0,4)
songsLayout.SortOrder=Enum.SortOrder.LayoutOrder
songsLayout.Parent=songsScroll
local songsPadding=Instance.new("UIPadding")
songsPadding.PaddingTop=UDim.new(0,6)
songsPadding.PaddingLeft=UDim.new(0,6)
songsPadding.PaddingRight=UDim.new(0,6)
songsPadding.PaddingBottom=UDim.new(0,6)
songsPadding.Parent=songsScroll
local radioSound=nil
local radioVolume=10
for _,song in ipairs(songs) do
local sBtn=Instance.new("TextButton")
sBtn.Size=UDim2.new(1,-8,0,28)
sBtn.BackgroundColor3=Color3.fromRGB(28,30,42)
sBtn.BorderSizePixel=0
sBtn.Text=song.name
sBtn.TextColor3=Color3.fromRGB(200,210,230)
sBtn.Font=Enum.Font.Gotham
sBtn.TextSize=11
sBtn.TextXAlignment=Enum.TextXAlignment.Left
sBtn.TextTruncate=Enum.TextTruncate.AtEnd
sBtn.Parent=songsScroll
local sCorner=Instance.new("UICorner")
sCorner.CornerRadius=UDim.new(0,6)
sCorner.Parent=sBtn
local sPad=Instance.new("UIPadding")
sPad.PaddingLeft=UDim.new(0,8)
sPad.Parent=sBtn
sBtn.MouseButton1Click:Connect(function()
idBox.Text=song.id
if radioSound then radioSound:Stop() radioSound:Destroy() end
radioSound=Instance.new("Sound")
radioSound.SoundId="rbxassetid://"..song.id
radioSound.Volume=radioVolume
radioSound.Looped=true
radioSound.Parent=workspace
radioSound:Play()
sBtn.BackgroundColor3=Color3.fromRGB(50,120,60)
task.wait(0.3)
sBtn.BackgroundColor3=Color3.fromRGB(28,30,42)
end)
end
songsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
songsScroll.CanvasSize=UDim2.new(0,0,0,songsLayout.AbsoluteContentSize.Y+15)
end)
local draggingVol=false
volKnob.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
draggingVol=true
end
end)
UserInputService.InputEnded:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
draggingVol=false
end
end)
UserInputService.InputChanged:Connect(function(input)
if draggingVol and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
local rel=math.clamp((input.Position.X-volBar.AbsolutePosition.X)/volBar.AbsoluteSize.X,0,1)
volFill.Size=UDim2.new(rel,0,1,0)
volKnob.Position=UDim2.new(rel,-8,0.5,-8)
radioVolume=rel*10
if radioSound then radioSound.Volume=radioVolume end
volLbl.Text="Громкость: "..math.floor(rel*100).."%"
end
end)
playBtn.MouseButton1Click:Connect(function()
local id=tonumber(idBox.Text)
if not id then return end
if radioSound then radioSound:Stop() radioSound:Destroy() end
radioSound=Instance.new("Sound")
radioSound.SoundId="rbxassetid://"..id
radioSound.Volume=radioVolume
radioSound.Looped=true
radioSound.Parent=workspace
radioSound:Play()
end)
stopBtn.MouseButton1Click:Connect(function()
if radioSound then radioSound:Stop() radioSound:Destroy() radioSound=nil end
end)
rClose.MouseButton1Click:Connect(function()
if radioSound then radioSound:Stop() radioSound:Destroy() radioSound=nil end
radioGui:Destroy()
radioGui=nil
end)
end
local function handleCommand(text)
local upper=text:upper():gsub("%s+","")
if upper=="ANTIFLING" then
addMessage("ANTI FLING включен",false,Color3.fromRGB(255,150,150))
enableAntiFling()
return true
end
if upper=="NOCLIP" then
addMessage("NOCLIP включен",false,Color3.fromRGB(150,255,180))
enableNoclip()
return true
end
if upper=="RADIO" then
addMessage("Радио открыто",false,Color3.fromRGB(255,220,150))
openRadio()
return true
end
return false
end
local function askAI(prompt)
addMessage(prompt,true)
local localAnswer=findLocalAnswer(prompt)
if localAnswer then
task.wait(0.15)
addMessage(localAnswer,false)
return
end
showThinking()
local cleanPrompt=prompt:gsub("[%c%z]",""):gsub("%s+"," ")
if #cleanPrompt>200 then cleanPrompt=cleanPrompt:sub(1,200) end
local fullPrompt="Отвечай кратко на русском, по делу: "..cleanPrompt
local encoded=HttpService:UrlEncode(fullPrompt)
local models={"openai","openai-fast","mistral"}
local body=nil
for _,model in ipairs(models) do
local url="https://text.pollinations.ai/"..encoded.."?model="..model
local ok,resp=pcall(function() return game:HttpGet(url) end)
if ok and resp and resp~="" and not (resp:sub(1,1)=="{" and resp:find('"error"')) then
body=resp
break
end
task.wait(0.1)
end
hideThinking()
if not body or body=="" then
addMessage("Сервер не отвечает. Попробуй ещё раз.",false)
return
end
local reply=tostring(body)
reply=reply:gsub("^%s+",""):gsub("%s+$","")
addMessage(reply,false)
end
local busy=false
local function trySend()
if busy then return end
if inputBox.Text~="" then
local q=inputBox.Text
inputBox.Text=""
if handleCommand(q) then return end
busy=true
task.spawn(function()
askAI(q)
busy=false
end)
end
end
inputBtn.MouseButton1Click:Connect(function()
inputBtn.Visible=false
inputBox.Visible=true
inputBox:CaptureFocus()
end)
inputBox.FocusLost:Connect(function(enterPressed)
if enterPressed then trySend() end
if inputBox.Text=="" then
inputBox.Visible=false
inputBtn.Visible=true
end
end)
UserInputService.InputBegan:Connect(function(i,gp)
if gp then return end
if i.KeyCode==Enum.KeyCode.Return and inputBox:IsFocused() then
trySend()
end
end)
local isOpen=false
openBtn.MouseButton1Click:Connect(function()
if movedBtn then return end
if isOpen then
isOpen=false
local t=TweenService:Create(mainFrame,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0)})
t:Play()
t.Completed:Connect(function() mainFrame.Visible=false end)
else
isOpen=true
mainFrame.Visible=true
mainFrame.Size=UDim2.new(0,0,0,0)
if not hasWritten then commandsFrame.Visible=true else commandsFrame.Visible=false end
TweenService:Create(mainFrame,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,440,0,380)}):Play()
end
end)
closeBtn.MouseButton1Click:Connect(function()
if isOpen then
isOpen=false
local t=TweenService:Create(mainFrame,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0)})
t:Play()
t.Completed:Connect(function() mainFrame.Visible=false end)
end
end)