--//=======================================================================================
--//                 Author:  @fiskce / @IcezDK	 	  Date: 12/07/2020                      
--//=======================================================================================
--//                      x-fiskce/serverscripts/fnpcs/client.lua	                  	    
--//                               Create NPCS at coords                                
--//                             									                                        
--//=======================================================================================

local coordonate = {
   {144.14,-1480.54,28.36,"Amfetamin Anders",124.51,0x0F977CEB,"s_m_y_chef_01"},
   {-1512.64,1522.29,110.62,"Hash Hamid",164.43,0x9D0087A8,"ig_claypain"},
   {-44.93,-1751.18,28.43,"Tobi",318.5,0x6857C9B7,"a_m_m_soucent_01"},
   {118.53, -1920.98, 20.32,"Mohammed",46.6,0xCF92ADE9,"a_m_y_stbla_01"},
    {115.35, -1954.53, 19.75,"Pede",24.67,0x30DB9D7B,"cs_chengsr"},
    {116.15, -1953.68, 19.75,"Benny",44.64,0x7E0961B8,"a_m_y_beachvesp_01"},
    {-46.63, -1757.72, 28.42,"Fiskbæk",49.71,0xBDBB4922,"ig_brad"},
    {121.2, -1947.43, 19.75,"Måge",88.78,0x9D0087A8,"ig_claypain"},
}

Citizen.CreateThread(function()

    for _,v in pairs(coordonate) do
      RequestModel(GetHashKey(v[7]))
      while not HasModelLoaded(GetHashKey(v[7])) do
        Wait(1)
      end
  
      RequestAnimDict("mini@strip_club@idles@bouncer@base")
      while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
      end
      ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        Citizen.Wait(0)
        for _,v in pairs(coordonate) do
            x = v[1]
            y = v[2]
            z = v[3]
            if(Vdist(pos.x, pos.y, pos.z, x, y, z) < 32.5)then
                DrawText3D(x,y,z+2.10, "~g~"..v[4], 1.2, 1)
                DrawText3D(x,y,z+1.95, "~w~Dealer", 1.0, 1)
            end
        end
    end
end)


function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--END


