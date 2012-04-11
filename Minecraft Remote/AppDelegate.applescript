--
--  AppDelegate.applescript
--  Minecraft Remote
--
--  Created by me on 4/7/12.
--  Copyright (c) 2012 Will Smillie. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
    
    
    --------------------------
    --main set up to run------
    --------------------------
    
    --runs when you press the 'connect button'
    on Connect_(sender)
        tell application "Terminal"
            
            --get to the Minecraft diriectory
            do script "cd /users/" -- opens a new window (leave this line)
            delay 4
            
            
            do script "ssh user@example.com" in window 1 --ssh into your server (leave the 'ssh' part)
            delay 4
            do script "yourPasswordHere" in window 1 --put ur password here
            delay 3
            do script "cd /path/to/your/minecraft/directory/" in window 1 -- the diriectory to ur minecraft folder (leave the 'cd' part)
            delay 2
            
            -----------------------------------------
            --if your using a local server use this--
            --and comment the other stuff out--------
            -----------------------------------------
            
            --do script "cd /path/to/your/minecraft/directory/" in window 1
            --delay 2
            
            
            --now to open up the current screen process
            --customize the rest to your liking
            do script "killall screen" in window 1 
            delay 2
            do script "screen" in window 1
            delay 2
            do script "screen ./start.sh" in window 1 --if you dont have a start script do this:
            --do script "java -Xms512M -Xmx512M -jar craftbukkit.jar" in window 1 --change the craftbukkit.jar to the name of ur server file
        end tell
    end Connect_
    
    
    ------------------------
    --button functions------
    ------------------------
    
    --toggle rain command
    on toggleRain_(sender)
        tell application "Terminal"
            do script "toggledownfall" in window 1
        end tell
    end toggleRain_
    
    --make day command
    on makeDay_(sender)
        tell application "Terminal"
            do script "time day" in window 1
        end tell
    end makeDay_

    --make night command
    on makeNight_(sender)
        tell application "Terminal"
            do script "time night" in window 1
        end tell
    end makeNight_
    
    -- list online users command
    on list_(sender)
        tell application "Terminal"
            do script "list" in window 1
        end tell
    end list_

    --save map command
    on save_(sender)
        tell application "Terminal"
            do script "save-all" in window 1
        end tell
    end save_

    --restart server command
    on restart_(sender)
        tell application "Terminal"
            do script "reload" in window 1
        end tell
    end restart_
    
    --stop server command
    on stop_(sender)
        tell application "Terminal"
            do script "stop" in window 1
            delay 8
            do script "exit" in window 1
        end tell
    end stop_


    ----------------------------------
    --say button text field stuff-----
    ----------------------------------
    
	property textView : missing value
	property textField : missing value
	property aWindow : missing value
    
   	on say_(sender)
		set textFieldValue to textField's stringValue()
		textView's setString_(textFieldValue)
        
        tell application "Terminal"
            do script "say " & textFieldValue in window 1
            log(textFieldValue)
        end tell
	end say_
 
    on awakeFromNib()
		textView's setTextContainerInset_({15.0, 10.0})
		--textField's setStringValue_("Default text")
		aWindow's makeFirstResponder_(textField)
	end awakeFromNib


  
    -----------------------------------
    --command button text field stuff--
    -----------------------------------
    
    property cmdTextView : missing value
    property cmdTextField : missing value
    property aCmdWindow : missing value
    
    on otherCmd_(sender)
		set cmdTextFieldValue to cmdTextField's stringValue()
		cmdTextView's setString_(cmdTextFieldValue)
        
        tell application "Terminal"
            do script "" & cmdTextFieldValue in window 1
            log(cmdTextFieldValue)
        end tell
	end otherCmd_

    on cmdawakeFromNib()
		cmdTextView's setCmdTextContainerInset_({15.0, 10.0})
		--textField's setStringValue_("Default text")
		aCmdWindow's makeCmdFirstResponder_(textField)
	end cmdawakeFromNib

                
    ---------------------
    ---other app stuff--
    --------------------
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script