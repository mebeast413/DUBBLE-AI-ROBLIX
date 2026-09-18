
local HttpService=game:GetService("HttpService")
local UserInputService=game:GetService("UserInputService")
local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local RunService=game:GetService("RunService")
local Lighting=game:GetService("Lighting")
local player=Players.LocalPlayer
local gui=Instance.new("ScreenGui")
gui.Name="DubbleAI"
gui.ResetOnSpawn=false
gui.DisplayOrder=999
gui.IgnoreGuiInset=true
gui.Parent=player:WaitForChild("PlayerGui")

local CREATOR_TAG="[ ------->ТГ СОЗДАТЕЛЯ @WYIHF<------- ]"
local settings={lang="ru",theme="dark",aiName="DUBBLE AI"}

local texts={
ru={placeholder="напишите запрос...",commands="КОМАНДЫ (напиши в чат):",wait="Подожди, Нейросеть думает...",error="Сервер не отвечает. Попробуй ещё раз.",settings="⚙️ НАСТРОЙКИ",lang="Язык:",ru_lang="РУССКИЙ",en_lang="АНГЛИЙСКИЙ",theme="Тема:",theme_dark="ЧЁРНАЯ ТЕМА",theme_light="БЕЛАЯ ТЕМА",theme_crystals="ЧЁРНАЯ ТЕМА С КРИСТАЛЛАМИ",name="Имя нейросети:",apply="ПРИМЕНИТЬ",back="НАЗАД"},
en={placeholder="type your request...",commands="COMMANDS (type in chat):",wait="Wait, AI is thinking...",error="Server not responding. Try again.",settings="⚙️ SETTINGS",lang="Language:",ru_lang="RUSSIAN",en_lang="ENGLISH",theme="Theme:",theme_dark="DARK THEME",theme_light="LIGHT THEME",theme_crystals="DARK WITH CRYSTALS",name="AI name:",apply="APPLY",back="BACK"}}

local themes={
dark={bg=Color3.fromRGB(18,18,24),bg2=Color3.fromRGB(12,12,18),bg3=Color3.fromRGB(28,30,42),text=Color3.fromRGB(220,230,255),text2=Color3.fromRGB(150,160,190),accent=Color3.fromRGB(100,180,255),header=Color3.fromRGB(220,230,255),stroke=Color3.fromRGB(50,60,85),crystals=false},
light={bg=Color3.fromRGB(245,245,250),bg2=Color3.fromRGB(255,255,255),bg3=Color3.fromRGB(230,230,240),text=Color3.fromRGB(30,30,40),text2=Color3.fromRGB(90,90,110),accent=Color3.fromRGB(60,120,220),header=Color3.fromRGB(40,40,60),stroke=Color3.fromRGB(200,200,215),crystals=false},
crystals={bg=Color3.fromRGB(18,18,24),bg2=Color3.fromRGB(12,12,18),bg3=Color3.fromRGB(28,30,42),text=Color3.fromRGB(220,230,255),text2=Color3.fromRGB(150,160,190),accent=Color3.fromRGB(170,100,255),header=Color3.fromRGB(220,230,255),stroke=Color3.fromRGB(80,50,130),crystals=true}}

local knowledge={
{k={"привет","прив","хай","здарова","ку"},a="Привет! Чем помочь?"},
{k={"как дела","как ты"},a="Всё отлично! А у тебя как?"},
{k={"что делаешь"},a="Помогаю тебе!"},
{k={"кто ты","что ты"},a="Я DUBBLE AI."},
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
{id="73180347730720",name="Нас не догоняют"},
{id="128027817703253",name="Юность в сапогах"},
{id="119066634941346",name="Ты меня не ищи"},
{id="95632852758777",name="Верните в моду любовь"},
{id="106619031644220",name="Неистовый свет"},
{id="102172300933284",name="Мориарти (madkld)"}}

local uiRefs={theme={},crystalFrames={},cmdBoxes={}}

local function tr(k) return texts[settings.lang][k] or k end
local function T() return themes[settings.theme] end

local loadGui=Instance.new("ScreenGui")
loadGui.Name="DubbleLoad"
loadGui.ResetOnSpawn=false
loadGui.DisplayOrder=99999
loadGui.IgnoreGuiInset=true
loadGui.Parent=player:WaitForChild("PlayerGui")

local loadBg=Instance.new("Frame")
loadBg.Size=UDim2.new(1,0,1,0)
loadBg.BackgroundColor3=Color3.fromRGB(0,0,0)
loadBg.BackgroundTransparency=0.05
loadBg.BorderSizePixel=0
loadBg.Parent=loadGui

local loadBlur=Instance.new("BlurEffect")
loadBlur.Size=25
loadBlur.Parent=loadGui

local loadTitle=Instance.new("TextLabel")
loadTitle.Size=UDim2.new(1,0,0,60)
loadTitle.Position=UDim2.new(0,0,0.4,0)
loadTitle.BackgroundTransparency=1
loadTitle.Text="👾  DUBBLE AI  👾"
loadTitle.TextColor3=Color3.fromRGB(180,140,255)
loadTitle.TextScaled=true
loadTitle.Font=Enum.Font.GothamBold
loadTitle.Parent=loadBg

local loadStage=Instance.new("TextLabel")
loadStage.Size=UDim2.new(1,0,0,30)
loadStage.Position=UDim2.new(0,0,0.5,0)
loadStage.BackgroundTransparency=1
loadStage.Text="Инициализация"
loadStage.TextColor3=Color3.fromRGB(200,200,220)
loadStage.TextSize=18
loadStage.Font=Enum.Font.Gotham
loadStage.Parent=loadBg

local loadBarBg=Instance.new("Frame")
loadBarBg.Size=UDim2.new(0.5,0,0,6)
loadBarBg.Position=UDim2.new(0.25,0,0.6,0)
loadBarBg.BackgroundColor3=Color3.fromRGB(40,40,55)
loadBarBg.BorderSizePixel=0
loadBarBg.Parent=loadBg
local lbbc=Instance.new("UICorner");lbbc.CornerRadius=UDim.new(1,0);lbbc.Parent=loadBarBg

local loadBarFill=Instance.new("Frame")
loadBarFill.Size=UDim2.new(0,0,1,0)
loadBarFill.BackgroundColor3=Color3.fromRGB(180,100,255)
loadBarFill.BorderSizePixel=0
loadBarFill.Parent=loadBarBg
local lbfc=Instance.new("UICorner");lbfc.CornerRadius=UDim.new(1,0);lbfc.Parent=loadBarFill

local stages={
{text="Инициализация",t=1.4},
{text="Добавляю нейросеть",t=1.4},
{text="Проверяю",t=1.4},
{text="Почти готово...",t=1.4},
{text="Готово",t=1.4}}

task.spawn(function()
local totalTime=7
local timePerStage=totalTime/#stages
for i,st in ipairs(stages) do
    loadStage.Text=st.text
    local target=i/#stages
    local start=(i-1)/#stages
    local elapsed=0
    while elapsed<timePerStage do
        local dt=task.wait()
        elapsed=elapsed+dt
        local p=math.clamp(elapsed/timePerStage,0,1)
        loadBarFill.Size=UDim2.new(start+(target-start)*p,0,1,0)
    end
    loadBarFill.Size=UDim2.new(target,0,1,0)
end

loadStage.Text="Готово"
loadStage.TextColor3=Color3.fromRGB(0,255,100)
task.wait(0.4)

TweenService:Create(loadBg,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency=1}):Play()
TweenService:Create(loadTitle,TweenInfo.new(0.7),{TextTransparency=1}):Play()
TweenService:Create(loadStage,TweenInfo.new(0.7),{TextTransparency=1}):Play()
TweenService:Create(loadBarBg,TweenInfo.new(0.6),{BackgroundTransparency=1}):Play()
TweenService:Create(loadBarFill,TweenInfo.new(0.6),{BackgroundTransparency=1}):Play()
TweenService:Create(loadBlur,TweenInfo.new(0.8),{Size=0}):Play()

task.wait(0.9)
loadGui:Destroy()
end)

local function destroyCrystals()
for _,c in ipairs(uiRefs.crystalFrames) do
if c then c:Destroy() end
end
uiRefs.crystalFrames={}
end

local function isForbiddenZone(yOffset,height)
if yOffset<58 then return true end
if yOffset>height-60 then return true end
return false
end

local function createCrystals(parent,parentHeight)
local count=18
for i=1,count do
local size=math.random(6,14)
local c=Instance.new("Frame")
c.Size=UDim2.new(0,size,0,size)
c.BackgroundColor3=Color3.fromRGB(160+math.random(0,60),80+math.random(0,60),255)
c.BorderSizePixel=0
c.Rotation=45
c.ZIndex=1
c.Parent=parent
local corner=Instance.new("UICorner")
corner.CornerRadius=UDim.new(0,2)
corner.Parent=c
local gradient=Instance.new("UIGradient")
gradient.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(200,120,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(120,60,220))})
gradient.Rotation=45
gradient.Parent=c
local attempts=0
local placed=false
local x,y
while attempts<30 and not placed do
attempts=attempts+1
x=math.random(15,85)
y=math.random(10,90)
local yOffset=(y/100)*parentHeight
if not isForbiddenZone(yOffset,parentHeight) then placed=true end
end
if placed then
c.Position=UDim2.new(x/100,-size/2,y/100,-size/2)
c.BackgroundTransparency=math.random(20,60)/100
table.insert(uiRefs.crystalFrames,c)
task.spawn(function()
while c.Parent do
task.wait(math.random(8,20)/10)
if c.Parent then
TweenService:Create(c,TweenInfo.new(1),{BackgroundTransparency=math.random(30,70)/100}):Play()
end
end
end)
else
c:Destroy()
end
end
end

local function applyTheme()
local t=T()
if uiRefs.mainFrame then uiRefs.mainFrame.BackgroundColor3=t.bg end
if uiRefs.mainStroke then uiRefs.mainStroke.Color=t.stroke end
if uiRefs.chatScroll then uiRefs.chatScroll.BackgroundColor3=t.bg2;uiRefs.chatScroll.ScrollBarImageColor3=t.accent end
if uiRefs.inputBtn then uiRefs.inputBtn.BackgroundColor3=t.bg3;uiRefs.inputBtn.TextColor3=t.text2 end
if uiRefs.inputBox then uiRefs.inputBox.BackgroundColor3=t.bg3;uiRefs.inputBox.TextColor3=t.text;uiRefs.inputBox.PlaceholderColor3=t.text2 end
if uiRefs.header then uiRefs.header.TextColor3=t.header end
if uiRefs.headerLine then uiRefs.headerLine.BackgroundColor3=t.stroke end
if uiRefs.cmdTitle then uiRefs.cmdTitle.TextColor3=t.text end
if uiRefs.openBtn then uiRefs.openBtn.BackgroundColor3=t.bg end
if uiRefs.openLabel then uiRefs.openLabel.TextColor3=t.accent end
if uiRefs.openStroke then uiRefs.openStroke.Color=t.accent end
if uiRefs.settingsFrame then uiRefs.settingsFrame.BackgroundColor3=t.bg end
if uiRefs.sfTitle then uiRefs.sfTitle.TextColor3=t.text end
if uiRefs.langLbl then uiRefs.langLbl.TextColor3=t.text2 end
if uiRefs.themeLbl then uiRefs.themeLbl.TextColor3=t.text2 end
if uiRefs.nameLbl then uiRefs.nameLbl.TextColor3=t.text2 end
if uiRefs.ruBtn then uiRefs.ruBtn.BackgroundColor3=t.bg3;uiRefs.ruBtn.TextColor3=t.text end
if uiRefs.enBtn then uiRefs.enBtn.BackgroundColor3=t.bg3;uiRefs.enBtn.TextColor3=t.text end
if uiRefs.darkBtn then uiRefs.darkBtn.BackgroundColor3=t.bg3;uiRefs.darkBtn.TextColor3=t.text end
if uiRefs.lightBtn then uiRefs.lightBtn.BackgroundColor3=t.bg3;uiRefs.lightBtn.TextColor3=t.text end
if uiRefs.crystalsBtn then uiRefs.crystalsBtn.BackgroundColor3=t.bg3;uiRefs.crystalsBtn.TextColor3=t.text end
if uiRefs.backBtn then uiRefs.backBtn.BackgroundColor3=t.bg3;uiRefs.backBtn.TextColor3=t.text end
if uiRefs.nameInput then uiRefs.nameInput.BackgroundColor3=t.bg3;uiRefs.nameInput.TextColor3=t.text end
if uiRefs.applyNameBtn then uiRefs.applyNameBtn.BackgroundColor3=t.accent end
for _,box in ipairs(uiRefs.cmdBoxes) do
box.Frame.BackgroundColor3=t.bg3
box.Desc.TextColor3=t.text2
end
if settings.lang=="ru" and uiRefs.ruBtn then uiRefs.ruBtn.BackgroundColor3=t.accent end
if settings.lang=="en" and uiRefs.enBtn then uiRefs.enBtn.BackgroundColor3=t.accent end
if settings.theme=="dark" and uiRefs.darkBtn then uiRefs.darkBtn.BackgroundColor3=t.accent end
if settings.theme=="light" and uiRefs.lightBtn then uiRefs.lightBtn.BackgroundColor3=t.accent end
if settings.theme=="crystals" and uiRefs.crystalsBtn then uiRefs.crystalsBtn.BackgroundColor3=t.accent end
destroyCrystals()
if t.crystals and uiRefs.mainFrame then createCrystals(uiRefs.mainFrame,380) end
end

local function applyLang()
if uiRefs.header then uiRefs.header.Text="👾  "..settings.aiName.."  👾" end
if uiRefs.openLabel then uiRefs.openLabel.Text="👾  "..settings.aiName.."  👾" end
if uiRefs.inputBtn then uiRefs.inputBtn.Text=tr("placeholder") end
if uiRefs.inputBox then uiRefs.inputBox.PlaceholderText=tr("placeholder") end
if uiRefs.cmdTitle then uiRefs.cmdTitle.Text=tr("commands") end
if uiRefs.sfTitle then uiRefs.sfTitle.Text=tr("settings") end
if uiRefs.langLbl then uiRefs.langLbl.Text=tr("lang") end
if uiRefs.themeLbl then uiRefs.themeLbl.Text=tr("theme") end
if uiRefs.nameLbl then uiRefs.nameLbl.Text=tr("name") end
if uiRefs.ruBtn then uiRefs.ruBtn.Text=tr("ru_lang") end
if uiRefs.enBtn then uiRefs.enBtn.Text=tr("en_lang") end
if uiRefs.darkBtn then uiRefs.darkBtn.Text=tr("theme_dark") end
if uiRefs.lightBtn then uiRefs.lightBtn.Text=tr("theme_light") end
if uiRefs.crystalsBtn then uiRefs.crystalsBtn.Text=tr("theme_crystals") end
if uiRefs.applyNameBtn then uiRefs.applyNameBtn.Text=tr("apply") end
if uiRefs.backBtn then uiRefs.backBtn.Text=tr("back") end
end

local openBtn=Instance.new("TextButton")
openBtn.Size=UDim2.new(0,220,0,50)
openBtn.Position=UDim2.new(0.5,-110,0,10)
openBtn.BackgroundColor3=T().bg
openBtn.BackgroundTransparency=0.4
openBtn.Text=""
openBtn.BorderSizePixel=0
openBtn.AutoButtonColor=false
openBtn.Parent=gui
local oc=Instance.new("UICorner");oc.CornerRadius=UDim.new(1,0);oc.Parent=openBtn
local openStroke=Instance.new("UIStroke")
openStroke.Color=T().accent
openStroke.Thickness=1.5
openStroke.Transparency=0.4
openStroke.Parent=openBtn
local openLabel=Instance.new("TextLabel")
openLabel.Size=UDim2.new(1,0,1,0)
openLabel.BackgroundTransparency=1
openLabel.Text="👾  "..settings.aiName.."  👾"
openLabel.TextColor3=T().accent
openLabel.Font=Enum.Font.GothamBold
openLabel.TextSize=18
openLabel.Parent=openBtn
uiRefs.openBtn=openBtn
uiRefs.openLabel=openLabel
uiRefs.openStroke=openStroke

task.spawn(function()
local t=0
while openLabel.Parent do
t=t+0.05
local c=T().accent
local r=math.clamp(c.R*255+math.sin(t)*50,0,255)
local g=math.clamp(c.G*255+math.sin(t+1)*30,0,255)
local b=math.clamp(c.B*255+math.sin(t+1)*20,0,255)
openLabel.TextColor3=Color3.fromRGB(r,g,b)
task.wait(0.05)
end
end)

local draggingBtn=false
local dragBtnStart,dragBtnPos
local movedBtn=false
openBtn.InputBegan:Connect(function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
draggingBtn=true;movedBtn=false;dragBtnStart=input.Position;dragBtnPos=openBtn.Position
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
if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then draggingBtn=false end
end)

local mainFrame=Instance.new("Frame")
mainFrame.Size=UDim2.new(0,0,0,0)
mainFrame.Position=UDim2.new(0.5,0,0.5,0)
mainFrame.AnchorPoint=Vector2.new(0.5,0.5)
mainFrame.BackgroundColor3=T().bg
mainFrame.BorderSizePixel=0
mainFrame.ClipsDescendants=true
mainFrame.Visible=false
mainFrame.Active=true
mainFrame.Draggable=true
mainFrame.Parent=gui
local mc=Instance.new("UICorner");mc.CornerRadius=UDim.new(0,18);mc.Parent=mainFrame
local mainStroke=Instance.new("UIStroke")
mainStroke.Color=T().stroke
mainStroke.Thickness=1.5
mainStroke.Transparency=0.3
mainStroke.Parent=mainFrame
uiRefs.mainFrame=mainFrame
uiRefs.mainStroke=mainStroke

local mainContent=Instance.new("Frame")
mainContent.Size=UDim2.new(1,0,1,0)
mainContent.BackgroundTransparency=1
mainContent.Visible=true
mainContent.Parent=mainFrame

local header=Instance.new("TextLabel")
header.Size=UDim2.new(1,0,0,44)
header.BackgroundTransparency=1
header.Text="👾  "..settings.aiName.."  👾"
header.TextColor3=T().header
header.Font=Enum.Font.GothamBold
header.TextSize=18
header.Parent=mainContent
uiRefs.header=header

local headerLine=Instance.new("Frame")
headerLine.Size=UDim2.new(0.92,0,0,1)
headerLine.Position=UDim2.new(0.04,0,0,44)
headerLine.BackgroundColor3=T().stroke
headerLine.BackgroundTransparency=0.4
headerLine.BorderSizePixel=0
headerLine.Parent=mainContent
uiRefs.headerLine=headerLine

local settingsBtn=Instance.new("TextButton")
settingsBtn.Size=UDim2.new(0,30,0,30)
settingsBtn.Position=UDim2.new(0,8,0,7)
settingsBtn.BackgroundTransparency=1
settingsBtn.Text="⚙️"
settingsBtn.TextColor3=T().text
settingsBtn.TextSize=20
settingsBtn.Font=Enum.Font.GothamBold
settingsBtn.BorderSizePixel=0
settingsBtn.Parent=mainContent

local closeBtn=Instance.new("TextButton")
closeBtn.Size=UDim2.new(0,32,0,32)
closeBtn.Position=UDim2.new(1,-38,0,6)
closeBtn.BackgroundTransparency=1
closeBtn.Text="✖️"
closeBtn.TextColor3=Color3.fromRGB(255,100,100)
closeBtn.TextSize=18
closeBtn.Font=Enum.Font.GothamBold
closeBtn.BorderSizePixel=0
closeBtn.Parent=mainContent

local chatScroll=Instance.new("ScrollingFrame")
chatScroll.Size=UDim2.new(1,-20,1,-150)
chatScroll.Position=UDim2.new(0,10,0,52)
chatScroll.BackgroundColor3=T().bg2
chatScroll.BorderSizePixel=0
chatScroll.CanvasSize=UDim2.new(0,0,0,0)
chatScroll.ScrollBarThickness=6
chatScroll.ScrollBarImageColor3=T().accent
chatScroll.ScrollingDirection=Enum.ScrollingDirection.Y
chatScroll.ElasticBehavior=Enum.ElasticBehavior.Never
chatScroll.Parent=mainContent
local cc=Instance.new("UICorner");cc.CornerRadius=UDim.new(0,12);cc.Parent=chatScroll
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
uiRefs.chatScroll=chatScroll

local inputBtn=Instance.new("TextButton")
inputBtn.Size=UDim2.new(1,-20,0,46)
inputBtn.Position=UDim2.new(0,10,1,-56)
inputBtn.BackgroundColor3=T().bg3
inputBtn.Text=tr("placeholder")
inputBtn.TextColor3=T().text2
inputBtn.TextSize=14
inputBtn.Font=Enum.Font.Gotham
inputBtn.BorderSizePixel=0
inputBtn.TextXAlignment=Enum.TextXAlignment.Left
inputBtn.Parent=mainContent
local ic=Instance.new("UICorner");ic.CornerRadius=UDim.new(1,0);ic.Parent=inputBtn
local inputPad=Instance.new("UIPadding")
inputPad.PaddingLeft=UDim.new(0,25)
inputPad.Parent=inputBtn
uiRefs.inputBtn=inputBtn

local inputBox=Instance.new("TextBox")
inputBox.Size=UDim2.new(1,-20,0,46)
inputBox.Position=UDim2.new(0,10,1,-56)
inputBox.BackgroundColor3=T().bg3
inputBox.Text=""
inputBox.PlaceholderText=tr("placeholder")
inputBox.PlaceholderColor3=T().text2
inputBox.TextColor3=T().text
inputBox.TextSize=14
inputBox.Font=Enum.Font.Gotham
inputBox.BorderSizePixel=0
inputBox.ClearTextOnFocus=false
inputBox.TextXAlignment=Enum.TextXAlignment.Left
inputBox.Visible=false
inputBox.Parent=mainContent
local ibc=Instance.new("UICorner");ibc.CornerRadius=UDim.new(1,0);ibc.Parent=inputBox
local inputBoxPad=Instance.new("UIPadding")
inputBoxPad.PaddingLeft=UDim.new(0,25)
inputBoxPad.PaddingRight=UDim.new(0,25)
inputBoxPad.Parent=inputBox
uiRefs.inputBox=inputBox

local commandsFrame=Instance.new("Frame")
commandsFrame.Size=UDim2.new(1,0,1,0)
commandsFrame.Position=UDim2.new(0,0,0,52)
commandsFrame.BackgroundTransparency=1
commandsFrame.Parent=mainContent

local cmdTitle=Instance.new("TextLabel")
cmdTitle.Size=UDim2.new(1,-20,0,20)
cmdTitle.Position=UDim2.new(0,10,0,10)
cmdTitle.BackgroundTransparency=1
cmdTitle.Text=tr("commands")
cmdTitle.TextColor3=T().text
cmdTitle.Font=Enum.Font.GothamBold
cmdTitle.TextSize=12
cmdTitle.TextXAlignment=Enum.TextXAlignment.Left
cmdTitle.Parent=commandsFrame
uiRefs.cmdTitle=cmdTitle

local cmdList={
{name="ANTI FLING",desc="откл. колизию врагов",color=Color3.fromRGB(255,100,100)},
{name="NOCLIP",desc="проход сквозь стены",color=Color3.fromRGB(100,255,150)},
{name="RADIO",desc="радио с музыкой",color=Color3.fromRGB(255,200,100)}}
for i,cmd in ipairs(cmdList) do
local box=Instance.new("Frame")
box.Size=UDim2.new(1,-20,0,30)
box.Position=UDim2.new(0,10,0,45+(i-1)*35)
box.BackgroundColor3=T().bg3
box.BackgroundTransparency=0.2
box.BorderSizePixel=0
box.Parent=commandsFrame
local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(0,8);bc.Parent=box
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
descLbl.TextColor3=T().text2
descLbl.Font=Enum.Font.Gotham
descLbl.TextSize=11
descLbl.TextXAlignment=Enum.TextXAlignment.Right
descLbl.Parent=box
table.insert(uiRefs.cmdBoxes,{Frame=box,Desc=descLbl})
end

local settingsFrame=Instance.new("Frame")
settingsFrame.Size=UDim2.new(1,0,1,0)
settingsFrame.BackgroundColor3=T().bg
settingsFrame.BorderSizePixel=0
settingsFrame.Visible=false
settingsFrame.Parent=mainFrame
uiRefs.settingsFrame=settingsFrame

local sfTitle=Instance.new("TextLabel")
sfTitle.Size=UDim2.new(1,0,0,30)
sfTitle.BackgroundTransparency=1
sfTitle.Text=tr("settings")
sfTitle.TextColor3=T().text
sfTitle.Font=Enum.Font.GothamBold
sfTitle.TextSize=16
sfTitle.Parent=settingsFrame
uiRefs.sfTitle=sfTitle

local langLbl=Instance.new("TextLabel")
langLbl.Size=UDim2.new(1,-20,0,20)
langLbl.Position=UDim2.new(0,10,0,35)
langLbl.BackgroundTransparency=1
langLbl.Text=tr("lang")
langLbl.TextColor3=T().text2
langLbl.Font=Enum.Font.GothamBold
langLbl.TextSize=13
langLbl.TextXAlignment=Enum.TextXAlignment.Left
langLbl.Parent=settingsFrame
uiRefs.langLbl=langLbl

local ruBtn=Instance.new("TextButton")
ruBtn.Size=UDim2.new(0.45,0,0,32)
ruBtn.Position=UDim2.new(0,10,0,60)
ruBtn.BackgroundColor3=T().bg3
ruBtn.BorderSizePixel=0
ruBtn.Text=tr("ru_lang")
ruBtn.TextColor3=T().text
ruBtn.Font=Enum.Font.GothamBold
ruBtn.TextSize=12
ruBtn.Parent=settingsFrame
local rc=Instance.new("UICorner");rc.CornerRadius=UDim.new(0,8);rc.Parent=ruBtn
uiRefs.ruBtn=ruBtn

local enBtn=Instance.new("TextButton")
enBtn.Size=UDim2.new(0.45,0,0,32)
enBtn.Position=UDim2.new(0.5,5,0,60)
enBtn.BackgroundColor3=T().bg3
enBtn.BorderSizePixel=0
enBtn.Text=tr("en_lang")
enBtn.TextColor3=T().text
enBtn.Font=Enum.Font.GothamBold
enBtn.TextSize=12
enBtn.Parent=settingsFrame
local ec=Instance.new("UICorner");ec.CornerRadius=UDim.new(0,8);ec.Parent=enBtn
uiRefs.enBtn=enBtn

ruBtn.MouseButton1Click:Connect(function() settings.lang="ru";applyLang();applyTheme() end)
enBtn.MouseButton1Click:Connect(function() settings.lang="en";applyLang();applyTheme() end)

local themeLbl=Instance.new("TextLabel")
themeLbl.Size=UDim2.new(1,-20,0,20)
themeLbl.Position=UDim2.new(0,10,0,105)
themeLbl.BackgroundTransparency=1
themeLbl.Text=tr("theme")
themeLbl.TextColor3=T().text2
themeLbl.Font=Enum.Font.GothamBold
themeLbl.TextSize=13
themeLbl.TextXAlignment=Enum.TextXAlignment.Left
themeLbl.Parent=settingsFrame
uiRefs.themeLbl=themeLbl

local darkBtn=Instance.new("TextButton")
darkBtn.Size=UDim2.new(1,-20,0,32)
darkBtn.Position=UDim2.new(0,10,0,130)
darkBtn.BackgroundColor3=T().bg3
darkBtn.BorderSizePixel=0
darkBtn.Text=tr("theme_dark")
darkBtn.TextColor3=T().text
darkBtn.Font=Enum.Font.GothamBold
darkBtn.TextSize=12
darkBtn.Parent=settingsFrame
local dc=Instance.new("UICorner");dc.CornerRadius=UDim.new(0,8);dc.Parent=darkBtn
uiRefs.darkBtn=darkBtn

local lightBtn=Instance.new("TextButton")
lightBtn.Size=UDim2.new(1,-20,0,32)
lightBtn.Position=UDim2.new(0,10,0,167)
lightBtn.BackgroundColor3=T().bg3
lightBtn.BorderSizePixel=0
lightBtn.Text=tr("theme_light")
lightBtn.TextColor3=T().text
lightBtn.Font=Enum.Font.GothamBold
lightBtn.TextSize=12
lightBtn.Parent=settingsFrame
local lc=Instance.new("UICorner");lc.CornerRadius=UDim.new(0,8);lc.Parent=lightBtn
uiRefs.lightBtn=lightBtn

local crystalsBtn=Instance.new("TextButton")
crystalsBtn.Size=UDim2.new(1,-20,0,32)
crystalsBtn.Position=UDim2.new(0,10,0,204)
crystalsBtn.BackgroundColor3=T().bg3
crystalsBtn.BorderSizePixel=0
crystalsBtn.Text=tr("theme_crystals")
crystalsBtn.TextColor3=T().text
crystalsBtn.Font=Enum.Font.GothamBold
crystalsBtn.TextSize=12
crystalsBtn.Parent=settingsFrame
local crc=Instance.new("UICorner");crc.CornerRadius=UDim.new(0,8);crc.Parent=crystalsBtn
uiRefs.crystalsBtn=crystalsBtn

darkBtn.MouseButton1Click:Connect(function() settings.theme="dark";applyTheme() end)
lightBtn.MouseButton1Click:Connect(function() settings.theme="light";applyTheme() end)
crystalsBtn.MouseButton1Click:Connect(function() settings.theme="crystals";applyTheme() end)

local nameLbl=Instance.new("TextLabel")
nameLbl.Size=UDim2.new(1,-20,0,20)
nameLbl.Position=UDim2.new(0,10,0,245)
nameLbl.BackgroundTransparency=1
nameLbl.Text=tr("name")
nameLbl.TextColor3=T().text2
nameLbl.Font=Enum.Font.GothamBold
nameLbl.TextSize=13
nameLbl.TextXAlignment=Enum.TextXAlignment.Left
nameLbl.Parent=settingsFrame
uiRefs.nameLbl=nameLbl

local nameInput=Instance.new("TextBox")
nameInput.Size=UDim2.new(1,-110,0,32)
nameInput.Position=UDim2.new(0,10,0,270)
nameInput.BackgroundColor3=T().bg3
nameInput.BorderSizePixel=0
nameInput.Text=settings.aiName
nameInput.TextColor3=T().text
nameInput.Font=Enum.Font.Gotham
nameInput.TextSize=13
nameInput.ClearTextOnFocus=false
nameInput.Parent=settingsFrame
local nic=Instance.new("UICorner");nic.CornerRadius=UDim.new(0,8);nic.Parent=nameInput
local niPad=Instance.new("UIPadding");niPad.PaddingLeft=UDim.new(0,10);niPad.Parent=nameInput
uiRefs.nameInput=nameInput

local applyNameBtn=Instance.new("TextButton")
applyNameBtn.Size=UDim2.new(0,90,0,32)
applyNameBtn.Position=UDim2.new(1,-100,0,270)
applyNameBtn.BackgroundColor3=T().accent
applyNameBtn.BorderSizePixel=0
applyNameBtn.Text=tr("apply")
applyNameBtn.TextColor3=Color3.fromRGB(255,255,255)
applyNameBtn.Font=Enum.Font.GothamBold
applyNameBtn.TextSize=12
applyNameBtn.Parent=settingsFrame
local anc=Instance.new("UICorner");anc.CornerRadius=UDim.new(0,8);anc.Parent=applyNameBtn
uiRefs.applyNameBtn=applyNameBtn

applyNameBtn.MouseButton1Click:Connect(function()
if nameInput.Text~="" and nameInput.Text~=settings.aiName then
settings.aiName=nameInput.Text
applyLang()
end
end)

local backBtn=Instance.new("TextButton")
backBtn.Size=UDim2.new(1,-20,0,32)
backBtn.Position=UDim2.new(0,10,1,-42)
backBtn.BackgroundColor3=T().bg3
backBtn.BorderSizePixel=0
backBtn.Text=tr("back")
backBtn.TextColor3=T().text
backBtn.Font=Enum.Font.GothamBold
backBtn.TextSize=12
backBtn.Parent=settingsFrame
local bkc=Instance.new("UICorner");bkc.CornerRadius=UDim.new(0,8);bkc.Parent=backBtn
uiRefs.backBtn=backBtn

settingsBtn.MouseButton1Click:Connect(function()
mainContent.Visible=false
settingsFrame.Visible=true
end)

backBtn.MouseButton1Click:Connect(function()
settingsFrame.Visible=false
mainContent.Visible=true
end)

local thinkingLabel=nil
local antiFlingActive=false
local noclipActive=false

local function hideCommandsForever()
    if commandsFrame then
        commandsFrame.Visible=false
        commandsFrame:Destroy()
    end
end

local function addMessage(text,isUser,customColor)
if isUser then
    if commandsFrame and commandsFrame.Parent then
        hideCommandsForever()
    end
end
local lbl=Instance.new("TextLabel")
lbl.Size=UDim2.new(1,-20,0,0)
lbl.AutomaticSize=Enum.AutomaticSize.Y
lbl.BackgroundTransparency=1
if isUser then
lbl.Text="Ты: "..text
lbl.TextColor3=Color3.fromRGB(140,190,255)
else
if customColor then
lbl.Text=text
lbl.TextColor3=customColor
else
lbl.Text=settings.aiName..": "..text.."\n\n"..CREATOR_TAG
lbl.TextColor3=Color3.fromRGB(200,230,200)
end
end
lbl.Font=Enum.Font.Gotham
lbl.TextSize=13
lbl.TextWrapped=true
lbl.TextXAlignment=Enum.TextXAlignment.Left
lbl.TextYAlignment=Enum.TextYAlignment.Top
lbl.ZIndex=5
lbl.Parent=chatScroll
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
thinkingLabel.Text=tr("wait")
thinkingLabel.TextColor3=Color3.fromRGB(255,200,100)
thinkingLabel.Font=Enum.Font.Gotham
thinkingLabel.TextSize=13
thinkingLabel.TextWrapped=true
thinkingLabel.TextXAlignment=Enum.TextXAlignment.Left
thinkingLabel.ZIndex=5
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
radioFrame.BackgroundColor3=T().bg
radioFrame.BorderSizePixel=0
radioFrame.Active=true
radioFrame.Draggable=true
radioFrame.Parent=radioGui
local rcc=Instance.new("UICorner");rcc.CornerRadius=UDim.new(0,18);rcc.Parent=radioFrame
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
rLine.BackgroundColor3=T().stroke
rLine.BackgroundTransparency=0.4
rLine.BorderSizePixel=0
rLine.Parent=radioFrame
local idLbl=Instance.new("TextLabel")
idLbl.Size=UDim2.new(0.5,-15,0,20)
idLbl.Position=UDim2.new(0,10,0,50)
idLbl.BackgroundTransparency=1
idLbl.Text="ID:"
idLbl.TextColor3=T().text2
idLbl.Font=Enum.Font.Gotham
idLbl.TextSize=13
idLbl.TextXAlignment=Enum.TextXAlignment.Left
idLbl.Parent=radioFrame
local idBox=Instance.new("TextBox")
idBox.Size=UDim2.new(0.5,-15,0,40)
idBox.Position=UDim2.new(0,10,0,75)
idBox.BackgroundColor3=T().bg3
idBox.BorderSizePixel=0
idBox.Text=""
idBox.PlaceholderText="Введи ID..."
idBox.PlaceholderColor3=T().text2
idBox.TextColor3=T().text
idBox.Font=Enum.Font.Gotham
idBox.TextSize=14
idBox.ClearTextOnFocus=false
idBox.Parent=radioFrame
local idc=Instance.new("UICorner");idc.CornerRadius=UDim.new(0,10);idc.Parent=idBox
local volLbl=Instance.new("TextLabel")
volLbl.Size=UDim2.new(0.5,-15,0,20)
volLbl.Position=UDim2.new(0,10,0,125)
volLbl.BackgroundTransparency=1
volLbl.Text="Громкость: 100%"
volLbl.TextColor3=T().text2
volLbl.Font=Enum.Font.Gotham
volLbl.TextSize=13
volLbl.TextXAlignment=Enum.TextXAlignment.Left
volLbl.Parent=radioFrame
local volBar=Instance.new("Frame")
volBar.Size=UDim2.new(0.5,-15,0,6)
volBar.Position=UDim2.new(0,10,0,150)
volBar.BackgroundColor3=T().bg3
volBar.BorderSizePixel=0
volBar.Parent=radioFrame
local vbc=Instance.new("UICorner");vbc.CornerRadius=UDim.new(1,0);vbc.Parent=volBar
local volFill=Instance.new("Frame")
volFill.Size=UDim2.new(1,0,1,0)
volFill.BackgroundColor3=Color3.fromRGB(255,200,100)
volFill.BorderSizePixel=0
volFill.Parent=volBar
local vfc=Instance.new("UICorner");vfc.CornerRadius=UDim.new(1,0);vfc.Parent=volFill
local volKnob=Instance.new("TextButton")
volKnob.Size=UDim2.new(0,16,0,16)
volKnob.Position=UDim2.new(1,-8,0.5,-8)
volKnob.BackgroundColor3=Color3.fromRGB(255,220,150)
volKnob.BorderSizePixel=0
volKnob.Text=""
volKnob.Parent=volBar
local vkc=Instance.new("UICorner");vkc.CornerRadius=UDim.new(1,0);vkc.Parent=volKnob
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
local pc=Instance.new("UICorner");pc.CornerRadius=UDim.new(0,10);pc.Parent=playBtn
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
local sc=Instance.new("UICorner");sc.CornerRadius=UDim.new(0,10);sc.Parent=stopBtn
local songsLbl=Instance.new("TextLabel")
songsLbl.Size=UDim2.new(0.5,-15,0,20)
songsLbl.Position=UDim2.new(0.5,5,0,50)
songsLbl.BackgroundTransparency=1
songsLbl.Text="СПИСОК:"
songsLbl.TextColor3=T().text2
songsLbl.Font=Enum.Font.GothamBold
songsLbl.TextSize=11
songsLbl.TextXAlignment=Enum.TextXAlignment.Left
songsLbl.Parent=radioFrame
local songsScroll=Instance.new("ScrollingFrame")
songsScroll.Size=UDim2.new(0.5,-15,1,-140)
songsScroll.Position=UDim2.new(0.5,5,0,75)
songsScroll.BackgroundColor3=T().bg2
songsScroll.BorderSizePixel=0
songsScroll.CanvasSize=UDim2.new(0,0,0,0)
songsScroll.ScrollBarThickness=4
songsScroll.ScrollBarImageColor3=T().accent
songsScroll.Parent=radioFrame
local scc=Instance.new("UICorner");scc.CornerRadius=UDim.new(0,10);scc.Parent=songsScroll
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
sBtn.BackgroundColor3=T().bg3
sBtn.BorderSizePixel=0
sBtn.Text=song.name
sBtn.TextColor3=T().text
sBtn.Font=Enum.Font.Gotham
sBtn.TextSize=11
sBtn.TextXAlignment=Enum.TextXAlignment.Left
sBtn.TextTruncate=Enum.TextTruncate.AtEnd
sBtn.Parent=songsScroll
local sbcc=Instance.new("UICorner");sbcc.CornerRadius=UDim.new(0,6);sbcc.Parent=sBtn
local sPad=Instance.new("UIPadding");sPad.PaddingLeft=UDim.new(0,8);sPad.Parent=sBtn
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
sBtn.BackgroundColor3=T().bg3
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
addMessage("ANTI FLING ON",false,Color3.fromRGB(255,150,150))
enableAntiFling()
return true
end
if upper=="NOCLIP" then
addMessage("NOCLIP ON",false,Color3.fromRGB(150,255,180))
enableNoclip()
return true
end
if upper=="RADIO" then
addMessage("Radio opened",false,Color3.fromRGB(255,220,150))
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
local fullPrompt="Отвечай кратко на русском: "..cleanPrompt
local encoded=HttpService:UrlEncode(fullPrompt)
local url="https://text.pollinations.ai/"..encoded.."?model=openai"
local ok,body=pcall(function() return game:HttpGet(url) end)
hideThinking()
if not ok or not body or body=="" then
addMessage(tr("error"),false)
return
end
local reply=tostring(body):gsub("^%s+",""):gsub("%s+$","")
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
mainContent.Visible=true
settingsFrame.Visible=false
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