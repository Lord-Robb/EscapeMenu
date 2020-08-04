local background_color = Color(0, 0, 0, 240)
local whitecolor = Color(255,255,255,255)

surface.CreateFont( "EscMenu", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 30,
	weight = 500,
} )

surface.CreateFont( "EscMenuPlyInfo", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
} )

surface.CreateFont( "EscMenuHover", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 32,
	weight = 500,
} )

surface.CreateFont( "Timeanddate", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = 65,
	weight = 500,
} )

--[[hook.Add("HUDPaint", "robby_escmenu", function() 

local scw = ScrW()
local sch = ScrH()
local timestamp = os.time()
local timedate = os.date("%H:%M:%S -- %m/%d/%Y")

	if ValidPanel(EscBackgroundCol) == true then
					
		surface.SetFont("EscMenu")
		surface.SetTextColor(255,255,255)
		surface.SetTextPos(scw / 2, sch * .2)
		surface.DrawText(timedate)

	elseif ValidPanel(EscBackgroundCol) == false then end

end)--]]

--[[function tad:Think()
local timestamp = os.time()
local timedate = os.date("%H:%M:%S - %m/%d/%Y", timestamp)

	if ValidPanel(tad) then 
		tad:SetText(timedate)
	else end
end--]]

hook.Add("PreRender", "Robb_OpenEscapeMenu", function()

local sch = ScrH() -- used for pos & size
local scw = ScrW() -- used for pos & size
local gamemodes = {"darkrp", "starwarsrp"}

	--if input.IsKeyDown(KEY_)

	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
		if ValidPanel(EscBackgroundCol)  == false then -- check to see if escape menu is open

			gui.HideGameUI() -- Hide default escape menu

			-- \/\/ Background Blur \/\/
			EscBackgroundBlur = vgui.Create("DImage")
			EscBackgroundBlur:SetPos(0, 0)
			EscBackgroundBlur:SetSize(ScrW(), ScrH())
			EscBackgroundBlur:SetMaterial("3dblur")

			-- \/\/ Background Color \/\/
			EscBackgroundCol = vgui.Create( "DPanel" )
			EscBackgroundCol:SetPos(0,0)
			EscBackgroundCol:SetSize(ScrW(), ScrH())
			EscBackgroundCol:MakePopup()
			EscBackgroundCol:SetBackgroundColor(background_color)

			-- \/\/ Server Name @ Top \/\/
			tad = vgui.Create("DLabel", EscBackgroundCol)
			tad:SetPos(scw / 2 - 270, sch * 0.04)
			tad:SetSize(scw * .3,sch * .06)
			tad:SetTextColor(Color(255,255,255,255))
			tad:SetFont("Timeanddate")
			tad:SetText(GetHostName())

			-- \/\/ Player Information Panel \/\/
				plyinfo = vgui.Create( "DPanel", EscBackgroundCol )
				plyinfo:SetPos(scw * .792, sch / 2 - 200)
				plyinfo:SetSize(scw * .2, ScrH()/2.96)
				plyinfo:SetBackgroundColor(Color(15,15,15,220))
				plyinfo.Paint = function()
				surface.SetDrawColor(15, 15, 15,220) -- surface.SetDrawColor(4, 3, 7,220)
				surface.DrawRect(0, 0, plyinfo:GetWide(), plyinfo:GetTall())
				surface.SetDrawColor(255, 255, 255,220)
				surface.DrawOutlinedRect(0, 0, plyinfo:GetWide(), plyinfo:GetTall())	
				end
			-- \/\/ Player Information Text \/\/
			plih = vgui.Create( "DLabel", plyinfo )
			plih:SetPos(plyinfo:GetWide() / 2 - 100, plyinfo:GetTall() * 0.04)
			plih:SetSize(plyinfo:GetWide(), plyinfo:GetTall() * 0.1)
			plih:SetFont("EscMenu")
			plih:SetText("Player Information")

			pliname = vgui.Create( "DLabel", plyinfo )
			pliname:SetPos(plyinfo:GetWide() / 2 - 160, plyinfo:GetTall() * 0.16)
			pliname:SetSize(plyinfo:GetWide(), plyinfo:GetTall() * 0.4)
			pliname:SetFont("EscMenuPlyInfo")
			pliname:SetText("Name: "..LocalPlayer():GetName().."\nSteamID: "..LocalPlayer():SteamID().."\nJob: "..team.GetName(LocalPlayer():Team()).."\nSalary: $"..LocalPlayer():getDarkRPVar("salary").."") 

			-- \/\/ Resume Game Button \/\/
			Resume = vgui.Create( "DButton", EscBackgroundCol)
			Resume:SetSize(scw * .2, sch * .06) -- scw * .2, sch * .06
			Resume:SetPos(scw * .007, sch / 2 - 200) -- scw * .007, sch * .17
			Resume:SetTextColor(Color(255,255,255))
			Resume:SetFont("EscMenu")
			Resume:SetText("RESUME")
			Resume.DoClick = function()
				EscBackgroundCol:Remove()
				EscBackgroundBlur:Remove()
				gui.HideGameUI()
			end
			Resume.Paint = function()
				surface.SetDrawColor(15, 15, 15,220) -- surface.SetDrawColor(4, 3, 7,220)
				surface.DrawRect(0, 0, Resume:GetWide(), Resume:GetTall())
				surface.SetDrawColor(255, 255, 255,220)
				surface.DrawOutlinedRect(0, 0, Resume:GetWide(), Resume:GetTall())
				Resume:SetFont("EscMenu")
				if Resume:IsHovered() then
					surface.SetDrawColor(35, 35, 35,220) -- surface.SetDrawColor(4, 3, 7,220)
					surface.DrawRect(0, 0, Resume:GetWide(), Resume:GetTall())
					surface.SetDrawColor(255, 255, 255,220)
					surface.DrawOutlinedRect(0, 0, Resume:GetWide(), Resume:GetTall())
					Resume:SetFont("EscMenuHover")
				end
			end

            -- \/\/ Options Button \/\/
			options = vgui.Create("DButton", EscBackgroundCol)
			options:SetSize(scw * .2, sch * .06)
			options:SetPos(scw * .007, sch / 2 - 100)
			options:SetFont("EscMenu")
			options:SetTextColor(Color(255,255,255))
			options:SetText("OPTIONS")
			--options:SetConsoleCommand("gamemenucommand", "OpenOptionsDialog")
			options.DoClick = function()
				gui.ActivateGameUI()
				RunConsoleCommand("gamemenucommand", "OpenOptionsDialog")
			end
			options.Paint = function()
				surface.SetDrawColor(15, 15, 15,220)
				surface.DrawRect(0, 0, options:GetWide(), options:GetTall())
				surface.SetDrawColor(255, 255, 255,220)
				surface.DrawOutlinedRect(0, 0, options:GetWide(), options:GetTall())
				options:SetFont("EscMenu")
				if options:IsHovered() then
					surface.SetDrawColor(35, 35, 35,220) -- surface.SetDrawColor(4, 3, 7,220)
					surface.DrawRect(0, 0, options:GetWide(), options:GetTall())
					surface.SetDrawColor(255, 255, 255,220)
					surface.DrawOutlinedRect(0, 0, options:GetWide(), options:GetTall())
					options:SetFont("EscMenuHover")
				end
			end

			-- \/\/ Website Button \/\/
			website = vgui.Create("DButton", EscBackgroundCol)
			website:SetSize(scw * .2, sch * .06)
			website:SetPos(scw * .007, sch / 2)
			website:SetFont("EscMenu")
			website:SetTextColor(Color(255,255,255))
			website:SetText("WEBSITE")
			website.DoClick = function()
				gui.OpenURL("https://newsouthgaming.com/port/")
			end
			website.Paint = function()
				surface.SetDrawColor(15, 15, 15,220)
				surface.DrawRect(0, 0, website:GetWide(), website:GetTall())
				surface.SetDrawColor(255, 255, 255,220)
				surface.DrawOutlinedRect(0, 0, website:GetWide(), website:GetTall())
				website:SetFont("EscMenu")
				if website:IsHovered() then
					surface.SetDrawColor(35, 35, 35,220) -- surface.SetDrawColor(4, 3, 7,220)
					surface.DrawRect(0, 0, website:GetWide(), website:GetTall())
					surface.SetDrawColor(255, 255, 255,220)
					surface.DrawOutlinedRect(0, 0, website:GetWide(), website:GetTall())
					website:SetFont("EscMenuHover")
				end
			end

            -- \/\/ Workshop Collection Button \/\/
			--[[workshopcol = vgui.Create("DButton", EscBackgroundCol)
			workshopcol:SetSize(scw * .2, sch * .06)
			workshopcol:SetPos(scw * .007, sch / 2 + 100)
			workshopcol:SetFont("EscMenu")
			workshopcol:SetTextColor(Color(255,255,255))
			workshopcol:SetText("WORKSHOP COLLECTION")
			workshopcol.DoClick = function()
				RunConsoleCommand("disconnect")
			end
			workshopcol.Paint = function()
				surface.SetDrawColor(15, 15, 15,220)
				surface.DrawRect(0, 0, workshopcol:GetWide(), workshopcol:GetTall())
				surface.SetDrawColor(255, 255, 255,220)
				surface.DrawOutlinedRect(0, 0, workshopcol:GetWide(), workshopcol:GetTall())
				workshopcol:SetFont("EscMenu")
				if workshopcol:IsHovered() then
					surface.SetDrawColor(35, 35, 35,220) -- surface.SetDrawColor(4, 3, 7,220)
					surface.DrawRect(0, 0, workshopcol:GetWide(), workshopcol:GetTall())
					surface.SetDrawColor(255, 255, 255,220)
					surface.DrawOutlinedRect(0, 0, workshopcol:GetWide(), workshopcol:GetTall())
					workshopcol:SetFont("EscMenuHover")
				end
			end--]]


			-- \/\/ Disconnect Button \/\/
			discbut = vgui.Create("DButton", EscBackgroundCol)
			discbut:SetSize(scw * .2, sch * .06)
			discbut:SetPos(scw * .007, sch / 2 + 100)
			discbut:SetFont("EscMenu")
			discbut:SetTextColor(Color(255,255,255))
			discbut:SetText("RAGE QUIT")
			discbut.DoClick = function()
				RunConsoleCommand("disconnect")
			end
			discbut.Paint = function()
				surface.SetDrawColor(15, 15, 15,220)
				surface.DrawRect(0, 0, discbut:GetWide(), discbut:GetTall())
				surface.SetDrawColor(255, 255, 255,220)
				surface.DrawOutlinedRect(0, 0, discbut:GetWide(), discbut:GetTall())
				discbut:SetFont("EscMenu")
				if discbut:IsHovered() then
					surface.SetDrawColor(35, 35, 35,220) -- surface.SetDrawColor(4, 3, 7,220)
					surface.DrawRect(0, 0, discbut:GetWide(), discbut:GetTall())
					surface.SetDrawColor(255, 255, 255,220)
					surface.DrawOutlinedRect(0, 0, discbut:GetWide(), discbut:GetTall())
					discbut:SetFont("EscMenuHover")
				end
			end

		elseif ValidPanel(EscBackgroundCol) then -- If escape menu is open then close it

			gui.HideGameUI()
			EscBackgroundCol:Remove()
			EscBackgroundBlur:Remove()
			plyinfo:Remove()
			tad:Remove()
			Resume:Remove()

		end
	
	end

end )

--[[if ValidPanel(EscBackgroundCol) == true then
	function tad:Think() 
		local timestamp = os.time()
		local timedate = os.date("%H:%M:%S - %m/%d/%Y", timestamp)
		tad:SetText(timedate)
	end
elseif ValidPanel(EscBackgroundCol) == false then end--]]

--[[-------------------------------------------------------------------------
TOP PORTION (TIME, PLAYTIME, ETC.)
---------------------------------------------------------------------------]]
--[[hook.Add("HUDPaint", "robby_escmenu", function() 

local scw = ScrW()
local sch = ScrH()
local timestamp = os.time()
local timedate = os.date("%H:%M:%S -- %m/%d/%Y")

	if ValidPanel(EscBackgroundCol) == true then
		
		surface.SetFont("EscMenu")
		surface.SetTextColor(255,255,255)
		surface.SetTextPos(scw / 2, sch * .2)
		surface.DrawText(timedate)

	elseif ValidPanel(EscBackgroundCol) == false then end

end)--]]