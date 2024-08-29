--[[ Copyright (c) 2010 Manuel "Roujin" Wolf

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. --]]

class "UIAddonMenu" (UIResizable)

local UIAddonMenu = _G["UIAddonMenu"]

local col_bg = {
   red = 154,
   green = 146,
   blue = 198,
 }
 
local col_highlight = {
  red = 174,
  green = 166,
  blue = 218,
}

local col_shadow = {
  red = 134,
  green = 126,
  blue = 178,
}

local col_caption = {
  red = 174,
  green = 166,
  blue = 218,
}

function UIAddonMenu:UIAddonMenu(ui)
  self:UIResizable(ui, 410, 300, col_bg)

  local app = ui.app
  self.ui = ui
  self.resizable = false
  self:setDefaultPosition(-20, -20)
  self.white_font = app.gfx:loadFont("QData", "Font01V")
  
  -- Title
  self:addBevelPanel(20, 10, 370, 20, col_caption):setLabel("Addon Menu")
  
  -- Addons
  if not pcall(function()
    local palette = ui.app.gfx:loadPalette("QData", "DrugN01V.pal", true)
    self.panel_sprites = ui.app.gfx:loadSpriteTable("QData", "DrugN02V", true, palette)
    self.border_sprites = ui.app.gfx:loadSpriteTable("Bitmap", "aux_ui", true)
  end) then
    self:close()
    return
  end
  
  self:addBevelPanel(20, 60, 140, 20, col_bg):setLabel(_S.custom_game_window.free_build).lowered = true
  local button =  self:addPanel(12, 170, 55):makeToggleButton(0, 0, 29, 29, 11, self.buttonFreebuild)
    :setTooltip(_S.tooltip.custom_game_window.free_build)
  if self.ui.app.config.free_build_mode then
    button:toggle()
  end
    
  self:addBevelPanel(210, 60, 140, 20, col_bg):setLabel("Endless Mode").lowered = true
  local button =  self:addPanel(12, 360, 55):makeToggleButton(0, 0, 29, 29, 11, self.buttonEndless)
    :setTooltip(_S.tooltip.custom_game_window.free_build)
  if self.ui.app.config.endless then
    button:toggle()
  end
  
  self:addBevelPanel(20, 100, 140, 20, col_bg):setLabel("Patient Flood").lowered = true
  local button =  self:addPanel(12, 170, 95):makeToggleButton(0, 0, 29, 29, 11, self.buttonFlood)
    :setTooltip(_S.tooltip.custom_game_window.free_build)
  if self.ui.app.config.patient_flood then
    button:toggle()
  end
  
  -- Reset and Close buttons
  
  self:addBevelPanel(190, 250, 100, 40, col_bg)
    :setLabel("Reset")
    :makeButton(0, 0, 100, 40, 11, self.buttonClose)
    :setTooltip(_S.tooltip.custom_game_window.load_selected_level)
	
  self:addBevelPanel(300, 250, 100, 40, col_bg)
    :setLabel("Close")
    :makeButton(0, 0, 100, 40, 11, self.buttonClose)
    :setTooltip(_S.tooltip.custom_game_window.load_selected_level)
  
end

function UIAddonMenu:draw(canvas, x, y)
  UIResizable.draw(self, canvas, x, y)

  -- Draw tip
  x, y = self.x + x, self.y + y
end

function UIAddonMenu:buttonFreebuild(checked)
  self.ui.app.config.free_build_mode = checked
end

function UIAddonMenu:buttonEndless(checked)
  self.ui.app.config.endless = checked
end

function UIAddonMenu:buttonFlood(checked)
  self.ui.app.config.patient_flood = checked
end

function UIAddonMenu:buttonReset()
  print("reset button pressed")
end

function UIAddonMenu:buttonClose()
  self:close()
end

