local repo = 'https://raw.githubusercontent.com/zachisfunny/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')

--[[ TabBox Example:
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Tab 1')
]]

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true,
    Tooltip = 'This is a tooltip',
})

Toggles.MyToggle:OnChanged(function()
    print('MyToggle changed to:', Toggles.MyToggle.Value)
end)

Toggles.MyToggle:SetValue(false)

local MyButton = LeftGroupBox:AddButton('Button', function()
    print('You clicked a button!')
end)

local MyButton2 = MyButton:AddButton('Sub button', function()
    print('You clicked a sub button!')
end)

MyButton:AddTooltip('This is a button')
MyButton2:AddTooltip('This is a sub button')

--[[ Multi Options Button
LeftGroupBox:AddButton('Kill all', Functions.KillAll):AddTooltip('This will kill everyone in the game!'):AddButton('Kick all', Functions.KickAll):AddTooltip('This will kick everyone in the game!')
]]

LeftGroupBox:AddLabel('This is a label')
LeftGroupBox:AddLabel('This is a label\n\nwhich wraps its text!', true)

LeftGroupBox:AddDivider()

LeftGroupBox:AddSlider('MySlider', {
    Text = 'This is my slider!',
        
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,

    Compact = false,
})

local Number = Options.MySlider.Value
Options.MySlider:OnChanged(function()
    print('MySlider was changed! New value:', Options.MySlider.Value)
end)

Options.MySlider:SetValue(3)

LeftGroupBox:AddInput('MyTextbox', {
    Default = 'My textbox!',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'This is a textbox',
    Tooltip = 'This is a tooltip',

    Placeholder = 'Placeholder text',

})

Options.MyTextbox:OnChanged(function()
    print('Text updated. New text:', Options.MyTextbox.Value)
end)

LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip',
})

Options.MyDropdown:OnChanged(function()
    print('Dropdown got changed. New value:', Options.MyDropdown.Value)
end)

Options.MyDropdown:SetValue('This')

LeftGroupBox:AddDropdown('MyMultiDropdown', {

    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1, 
    Multi = true,

    Text = 'A dropdown',
    Tooltip = 'This is a tooltip',
})

Options.MyMultiDropdown:OnChanged(function()
    -- print('Dropdown got changed. New value:', )
    print('Multi dropdown got changed:')
    for key, value in next, Options.MyMultiDropdown.Value do
        print(key, value) -- should print something like This, true
    end
end)

Options.MyMultiDropdown:SetValue({
    This = true,
    is = true,
})

LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0), -- Bright green
    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
})

Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
end)

Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {

    Default = 'MB2',
    SyncToggleState = false, 
        
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold
        
    Text = 'Auto lockpick safes',
    NoUI = false,
})

Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker.Value)
end)

Options.KeyPicker:SetValue({ 'MB2', 'Toggle' })

Library:SetWatermarkVisibility(true)

Library:SetWatermark('This is a really long watermark to text the resizing')

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = false, Text = 'Menu keybind' }) 
MenuGroup:AddToggle('kbframevisible', {
    Text = 'Show Keybinds',
    Default = true,
    Tooltip = 'Shows your Keybinds',
})

Toggles.kbframevisible:OnChanged(function()
Library.KeybindFrame.Visible = Toggles.kbframevisible.Value
end)

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings() 

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

SaveManager:BuildConfigSection(Tabs['UI Settings']) 

ThemeManager:ApplyToTab(Tabs['UI Settings'])
