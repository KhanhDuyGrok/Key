-- // ⚙️ Cấu hình Game và Hệ thống KeyAuth
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- * CẤU HÌNH KEYAUTH *
local KeyAuth_Name = "Duyle11's Application"    -- * Tên Ứng dụng KeyAuth của bạn
local KeyAuth_Ownerid = "39CimOd5rU" -- * OwnerID Ứng dụng KeyAuth của bạn
local KeyAuth_APPVersion = "1.0" -- * Phiên bản Ứng dụng của bạn

local LuaName = "Hệ thống Xác thực Script"
local initialized = false
local sessionid = ""
local data_user = nil

local scriptName = tostring(getgenv().NScript or "Unknown")
local inputKey = tostring(getgenv().Key or "") -- Khóa người dùng nhập vào

-- // 📢 Hàm hiển thị thông báo
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

-- // 🔑 Hàm xác thực KeyAuth
local function Authenticate(key)
    Notify(LuaName, "Đang khởi tạo Xác thực...", 5)

    -- 1. Khởi tạo (Initialization)
    local init_url = 'https://keyauth.win/api/1.1/?name=' .. KeyAuth_Name .. '&ownerid=' .. KeyAuth_Ownerid .. '&type=init&ver=' .. KeyAuth_APPVersion
    local init_req = game:HttpGet(init_url)

    if init_req == "KeyAuth_Invalid" then
        Notify(LuaName, "Lỗi: Không tìm thấy Ứng dụng KeyAuth.", 3)
        return false
    end

    local init_data = HttpService:JSONDecode(init_req)

    if init_data.success == false then
        if init_data.message == "invalidver" then
            Notify(LuaName, "Lỗi: Sai phiên bản ứng dụng. Vui lòng cập nhật.", 3)
        else
            Notify(LuaName, "Lỗi Khởi tạo: " .. init_data.message, 3)
        end
        return false
    end

    initialized = true
    sessionid = init_data.sessionid

    -- 2. Xác thực Giấy phép (License)
    Notify(LuaName, "Đang kiểm tra Giấy phép...", 5)
    local license_url = 'https://keyauth.win/api/1.1/?name=' .. KeyAuth_Name .. '&ownerid=' .. KeyAuth_Ownerid .. '&type=license&key=' .. key ..'&ver=' .. KeyAuth_APPVersion .. '&sessionid=' .. sessionid
    local license_req = game:HttpGet(license_url)
    
    local license_data = HttpService:JSONDecode(license_req)

    if license_data.success == false then
        Notify(LuaName, "Lỗi Xác thực: " .. license_data.message, 5)
        return false
    end

    -- Xác thực thành công
    data_user = license_data.info -- Lưu thông tin người dùng
    Notify(LuaName, "Đã xác thực thành công! Chào mừng, " .. data_user.username, 5)
    return true
end

-- // 🏃‍ CHẠY HỆ THỐNG XÁC THỰC
if inputKey == "" then
    LocalPlayer:Kick("🚫 Vui lòng cung cấp khóa xác thực (Key) để sử dụng script.")
    return
end

local is_authorized = Authenticate(inputKey)

if not is_authorized then
    LocalPlayer:Kick("🚫 Xác thực thất bại. Vui lòng kiểm tra lại khóa của bạn.")
    return
end

-- // 🚀 Logic Tải Script (Chỉ chạy nếu đã xác thực thành công)

if scriptName == "MaruHub" then
    getgenv().NScript = "MaruHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "KaitunMaruDefault" then
    getgenv().NScript = "MaruHub"
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

-- ... Tiếp tục với các khối elseif khác (MaruKaitunFisch, MaruKaitunGrowAGarden, MaruKaitunBF, HoHoHub)
-- ... Giữ nguyên logic cấu hình và tải script của bạn
elseif scriptName == "MaruKaitunFisch" then
    getgenv().NScript = "MaruHub"
    -- [Cấu hình MaruKaitunFisch của bạn]
    -- ...
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
    
elseif scriptName == "MaruKaitunGrowAGarden" then
    getgenv().NScript = "MaruHub"
    -- [Cấu hình MaruKaitunGrowAGarden của bạn]
    -- ...
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "MaruKaitunBF" then
    getgenv().NScript = "MaruHub"
    -- [Cấu hình MaruKaitunBF của bạn]
    -- ...
    getgenv().Script_Mode = "Kaitun_Script"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()

elseif scriptName == "HoHoHub" then
    getgenv().NScript = "HohoHub"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Wraith1vs11/Rejoin/refs/heads/main/UGPhone's%20Scripts"))()
    
else
    LocalPlayer:Kick("🚫 Không xác định script cần chạy. (scriptName = " .. tostring(scriptName) .. ")")
end
