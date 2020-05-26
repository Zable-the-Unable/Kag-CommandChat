#include "CommandChatCommon.as";

class AllMats : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "allmats".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ wood = server_CreateBlob('mat_wood', -1, pos);
        wood.server_SetQuantity(500); // so I don't have to repeat the server_CreateBlob line again
        //stone
        CBlob@ stone = server_CreateBlob('mat_stone', -1, pos);
        stone.server_SetQuantity(500);
        //gold
        CBlob@ gold = server_CreateBlob('mat_gold', -1, pos);
        gold.server_SetQuantity(100);

        return true;
    }
}

class WoodStone : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "woodstone".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ b = server_CreateBlob('mat_wood', -1, pos);

        for (int i = 0; i < 2; i++)
        {
            CBlob@ b = server_CreateBlob('mat_stone', -1, pos);
        }

        return true;
    }
}

class StoneWood : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "stonewood".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ b = server_CreateBlob('mat_stone', -1, pos);

        for (int i = 0; i < 2; i++)
        {
            CBlob@ b = server_CreateBlob('mat_wood', -1, pos);
        }

        return true;
    }
}
class Wood : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "wood".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ b = server_CreateBlob('mat_wood', -1, pos);

        return true;
    }
}
class Stones : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "stones".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ b = server_CreateBlob('mat_stone', -1, pos);

        return true;
    }
}
class Gold : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "gold".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        for (int i = 0; i < 4; i++)
        {
            CBlob@ b = server_CreateBlob('mat_gold', -1, pos);
        }

        return true;
    }
}
class Tree : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "tree".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        server_MakeSeed(pos, "tree_pine", 600, 1, 16);

        return true;
    }
}
class BTree : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "btree".getHash();
            in_gamemode = "sandbox";
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        server_MakeSeed(pos, "tree_bushy", 400, 2, 16);

        return true;
    }
}
class AllArrows : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "allarrows".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ normal = server_CreateBlob('mat_arrows', -1, pos);
        CBlob@ water = server_CreateBlob('mat_waterarrows', -1, pos);
        CBlob@ fire = server_CreateBlob('mat_firearrows', -1, pos);
        CBlob@ bomb = server_CreateBlob('mat_bombarrows', -1, pos);

        return true;
    }
}
class Arrows : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "arrows".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ b = server_CreateBlob('mat_arrows', -1, pos);

        return true;
    }
}
class AllBombs : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "allbombs".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        for (int i = 0; i < 2; i++)
        {
            CBlob@ bomb = server_CreateBlob('mat_bombs', -1, pos);
        }
        CBlob@ water = server_CreateBlob('mat_waterbombs', -1, pos);

        return true;
    }
}
class Bombs : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "bombs".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        for (int i = 0; i < 3; i++)
        {
            CBlob@ b = server_CreateBlob('mat_bombs', -1, pos);
        }

        return true;
    }
}
class SpawnWater : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "spawnwater".getHash();
        }
        permlevel = Admin;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        getMap().server_setFloodWaterWorldspace(pos, true);

        return true;
    }
}
class Seed : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "seed".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        // crash prevention?              What? - Numan

        return true;
    }
}
class Scroll : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "scroll".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
        minimum_parameter_count = 1;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        string s = tokens[1];
        for (uint i = 2; i < tokens.length; i++)
        {
            s += " " + tokens[i];
        }
        server_MakePredefinedScroll(pos, s);

        return true;
    }
}

class FishySchool : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "fishyschool".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        for (int i = 0; i < 12; i++)
        {
            CBlob@ b = server_CreateBlob('fishy', -1, pos);
        }

        return true;
    }
}
class ChickenFlock : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "chickenflock".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        for (int i = 0; i < 12; i++)
        {
            CBlob@ b = server_CreateBlob('chicken', -1, pos);
        }

        return true;
    }
}
class Crate : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "crate".getHash();
        }
        permlevel = Moderator;
        commandtype = Legacy;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.size() > 1)
        {
            int frame = tokens[1] == "catapult" ? 1 : 0;
            string description = tokens.length > 2 ? tokens[2] : tokens[1];
            server_MakeCrate(tokens[1], description, frame, -1, Vec2f(pos.x, pos.y));
        }
        else
        {
            sendClientMessage(this, player, "usage: !crate BLOBNAME [DESCRIPTION]"); //e.g., !crate shark Your Little Darling
            server_MakeCrate("", "", 0, team, Vec2f(pos.x, pos.y - 30.0f));
        }

        return true;
    }
}

//!test (number) (playerusername) - Read the stuff below to be informed on how to make commands.
class Test : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)//Code in here happens only once.
        {
            names[0] = "test".getHash();//Assign the name used to use this command. Sending !test in the chat will activate this command
            names[1] = "testy".getHash();//Optionally, !testy can also be used to use this command
        }
        
        permlevel = Admin;//Assigns the permission level to be admin. You must be an admin to use this command.
			
        commandtype = Testing;//The type of command this is. This is only useful in displaying things in the interactive help menu (not yet made). So atm this does nothing.

        no_sv_test = true;//All commands besides those specified with no_sv_test = true; can be used when sv_test is 1. This command cannot be used when sv_test is 1.
    
        blob_must_exist = true;//If this is true, when the player's blob does not exist the command code will not run and the player will be informed that their blob is null.

        minimum_parameter_count = 0;//Specifies at minimum how many parameters a command must have. If the number of parameters is less than the minimum, some code prevents the command from running and tells the user.

        if(tokens.size() > 2)//This is an optional part. If there are more then 2 tokens, do the code inside. For example "!test 99 the1sad1numanator".  This has 3 tokens, 1: !test 2: 99 3: the1sad1numanator
        {//This is most useful when having a command that by default specifies the player that used it, but can specify another player with an additional parameter.

            blob_must_exist = false;//The player does not have to have a blob to use this command anymore.

            permlevel = SuperAdmin;//Reassign the perm level to be SuperAdmin. You must now be a SuperAdmin to use this command.
            
            target_player_slot = 2;//Specifies which token the playerusername is on. In this case it is the third token, but since things start from 0 in programming we assign it to 2. 
            //Specifying this tells some code to figure out what player has the specified username and put it into the "target_player" variable for later use in CommandCode. 
            //If the player does not exist, it will not run CommandCode and the client that ran this command will be informed.

            target_player_blob_param = true;//After getting the target_player, making this variable true will get the blob from the target_player and put it into the variable "target_blob".
            //Like the target_player, if the target_blob does not exist, CommandCode will not run and the client will be informed that the target_player had no blob.
            //These target_ variables are further used in CommandCode, look there if you are still confused.

            //Simply put, using target_player and target_blob allows you to not need to do null checks. It handles all that itself. 
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        sendClientMessage(this, player, "You just used the test command.");//This method sends a message to the specified player. the "player" variable is the player that used the !test command.

        if(tokens.length > 1)//If there is more than a single token. The first token is command itself, and the second token is the number in this case.
        {
            string string_number = tokens[1];//Here we get the very first parameter, the number, and put it in the string.

            u8 number = parseInt(string_number);//We take the very first parameter and turn it into an int variable with the name "number".
            
            sendClientMessage(this, player, "There is a parameter specified. The first parameter is: " + number);//Message the player that sent this command this.

            if (tokens.length > 2)//If there are more than two tokens. The first token is the command itself, the second is the number, the third is the specified player.
            {
                sendClientMessage(this, player, "There are two parameters specified, the second parameter is: " + tokens[2], SColor(255, 0, 0, 153));//This time we specify a color.
            
                //Tip, you do not need to check if the target_player or target_blob exist, that is already handled by something else.

                target_blob.server_setTeamNum(number);//As we specified the target_player_blob_param = true; when there are more than two tokens, we have the blob of the target_player right here.

                sendClientMessage(this, target_player, "Your team has been changed to " + number + " by " + player.getUsername() + " who is on team " + team);//This sends a message to the target_player
            }

            //If there is only 1 parameter (2 tokens) do this.
            else
            {
                blob.server_setTeamNum(number);//Set the player's blob that sent this command to the specified team.
            }
        }

        return true;//Returning true will send the message to chat. Only if you are a superadmin and have hidecomms on will it not.
        //return false;//Returning false will not send the message to chat.

    }
}
//!commands - Help, I'm being held hostage by my own brain 
class ShowCommands : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "commands".getHash();
            names[1] = "showcommands".getHash();
        }

        blob_must_exist = false;
        commandtype = TODO;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBitStream params;
        this.SendCommand(this.getCommandID("clientshowhelp"), params, player);
        return false;
    }
}
//!heldblobid - returns netid of held blob
class HeldBlobNetID : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "heldblobnetid".getHash();
            names[1] = "heldblobid".getHash();
            names[2] = "heldid".getHash();
        }
        
        blob_must_exist = true;
        commandtype = Debug;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ held_blob = blob.getCarriedBlob();
        if(held_blob != null)
        {
            sendClientMessage(this, player, "NetID: " + held_blob.getNetworkID());
        }
        else
        {
            sendClientMessage(this, player, "Held blob not found.");
        }

        return true;
    }
}
//!playerid (username) - returns netid of the player
class PlayerNetID : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "playerid".getHash();
            names[1] = "playernetid".getHash();
        }
        
        blob_must_exist = false;
        commandtype = Debug;
        
        
        if(tokens.size() > 1)
        {
            target_player_slot = 1;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.length > 1)
        {
            sendClientMessage(this, player, "NetID: " + target_player.getNetworkID());
        }
        else
        {
            sendClientMessage(this, player, "NetID: " + player.getNetworkID());
        }

        return true;
    }
}
//!playerblobid (username) - returns netid of players blob
class PlayerBlobNetID : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "playerblobnetid".getHash();
            names[1] = "playerblobid".getHash();
        }

        commandtype = Debug;
        
        if(tokens.size() > 1)
        {
            target_player_slot = 1;
            target_player_blob_param = true;
            blob_must_exist = false;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.length > 1)
        {
            sendClientMessage(this, player, "NetID: " + target_blob.getNetworkID());
        }
        else
        {
            sendClientMessage(this, player, "NetID: " + blob.getNetworkID());
        }

        return true;
    }
}
//!playercount - prints the playercount for just you
class PlayerCount : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "playercount".getHash();
        }
        
        blob_must_exist = false;
        commandtype = Info;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        uint16 playercount = getPlayerCount();
        if(playercount > 1) {
            sendClientMessage(this, player, "There are " + getPlayerCount() + " Players here.");
        }
        else {
            sendClientMessage(this, player, "It's just you.");
        }

        return true;
    }
}
//!announce {text - Put text in the screen of all clients for some time.
class Announce : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "announce".getHash();
        }
        

        blob_must_exist = false;
        no_sv_test = true;
        permlevel = Admin;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        string text_in;
        for(u16 i = 0; i < tokens.size(); i++)
        {
            if(i != 0)
            {
                text_in += " " + tokens[i];
            }
            else
            {
                text_in += tokens[i];
            }
        }
        CBitStream params;
        params.write_string(text_in.substr(tokens[0].length()));
        this.SendCommand(this.getCommandID("announcement"), params);

        return true;
    }
}
//!tagplayerblob "type" "tagname" "value" (PLAYERNAME) - defaults to yourself, type can equal "u8, s8, u16, s16, u32, s32, f32, bool, string, tag"
class TagPlayerBlob : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "tagplayerblob".getHash();
        }

        permlevel = Admin;
        minimum_parameter_count = 3;
        commandtype = Debug;

        if(tokens.size() > 4)
        {
            blob_must_exist = false;
            target_player_slot = 4;
            target_player_blob_param = true;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        string message = "";
        if(tokens.length > 4)
        {
            message = TagSpecificBlob(target_blob, tokens[1], tokens[2], tokens[3]);
        }
        else
        {
            message = TagSpecificBlob(blob, tokens[1], tokens[2], tokens[3]);
            @target_player = @player;
        }

        if(message == "")
        {
            if(tokens[1] == "tag")
            {
                string tag_or_untag = "tagged";
                if (tokens[3] == "false" || tokens[3] == "0")
                {
                    tag_or_untag = "untagged";
                }

                message = "player " + target_player.getUsername() + " has had their blob " + tag_or_untag + " with " + tokens[2];
            }
            else
            {
                message = "player " + target_player.getUsername() + " has their blob's " + tokens[1] + " value with the key " + tokens[2] + " set to " + tokens[3];
            }
        }

        if(message != "")
        {
            sendClientMessage(this, player, message);
        }

        return true;
    }
}
//!tagblob "type" "tagname" "value" "blobnetid" - type can equal "u8, s8, u16, s16, u32, s32, f32, bool, string, tag"
class TagBlob : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "tagblob".getHash();
        }
        
        blob_must_exist = false;
        permlevel = Admin;
        minimum_parameter_count = 4;
        commandtype = Debug;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        u16 netid = parseInt(tokens[4]);

        CBlob@ netidblob = getBlobByNetworkID(netid);

        string message = "";
        if(netidblob != null)
        {
            message = TagSpecificBlob(netidblob, tokens[1], tokens[2], tokens[3]);
        }
        else
        {
            message = "The blob with the specified NetID " + tokens[4] + " was null/not found.";
        }

        if(message == "")
        {
            if(tokens[1] == "tag")
            {
                string tag_or_untag = "tag";
                if (tokens[3] == "false" || tokens[3] == "0")
                {
                    tag_or_untag = "untag";
                }

                message = "The blob with the NetID " + tokens[4] + " has been " + tag_or_untag + " with " + tokens[2];
            }
            else
            {
                message = "The blob with the NetID " + tokens[4] + " has had their " + tokens[1] + " value with the key " + tokens[2] + " set to " + tokens[3];
            }
        }

        if(message != "")
        {
            sendClientMessage(this, player, message);
        }

        return true;
    }
}
//!hidecommands - after using this command you will no longer print your !command messages to chat, use again to disable this
class HideCommands : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "hidecommands".getHash();
        }
        
        blob_must_exist = false;
        permlevel = SuperAdmin;
        no_sv_test = true;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        //I'd like feedback on this, should people be able to hide their own commands? - Numan
        bool hidecom = false;
        if(this.get_bool(player.getUsername() + "_hidecom") == false)
        {
            sendClientMessage(this, player, "Commands hidden");
            hidecom = true;
        }
        else
        {
            sendClientMessage(this, player, "Commands unhidden");
        }
        
        
        this.set_bool(player.getUsername() + "_hidecom", hidecom);
        return false;
    }
}
//Spins everything. No questions asked.
class SpinEverything : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "spineverything".getHash();
        }
        
        blob_must_exist = false;
        permlevel = SuperAdmin;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        uint32 rotationvelocity = 100;
        if(tokens.length > 1)
        {
            rotationvelocity = parseInt(tokens[1]);
        }
        CBlob@[] blobs;
        getBlobs(@blobs); 
        for(int i = 0; i < blobs.length; i++)
        {
            CShape@ s = blobs[i].getShape();
            if(s != null)
            {
                s.server_SetActive(true); s.SetRotationsAllowed(true); s.SetStatic(false); s.SetAngularVelocity(XORRandom(rotationvelocity));
            }
        }

        return true;
    }
}
//sets the time, input between 0.0 - 1.0
class SetTime : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "settime".getHash();
        }

        blob_must_exist = false;
        permlevel = SuperAdmin;
        minimum_parameter_count = 1;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        float time = parseFloat(tokens[1]);
        getMap().SetDayTime(time);

        return true;
    }
}
//!givecoin "amount" "player" - Gives an amount of coin to a specified player, will deduct coin from your coins
class GiveCoin : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "givecoin".getHash();
        }

        blob_must_exist = false;
        target_player_slot = 2;//This command requires a player on the second argument (for this it would be !givecoin 10 xXGamerXx)
        minimum_parameter_count = 2;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        uint32 coins = parseInt(tokens[1]);

        if(player.getCoins() >= coins)
        {
            player.server_setCoins(player.getCoins() - coins);
            target_player.server_setCoins(target_player.getCoins() + coins);
            sendClientMessage(this, player, "You gave " + coins + " Coins To " + target_player.getCharacterName());
        }
        else
        {
            sendClientMessage(this, player, "You don't have enough coins");
            return false;
        }

        return true;
    }
}
//!pm "player" "message" - Sends the specified message to only one player, other players can not read into this and figure out what was sent
class PrivateMessage : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "pm".getHash();
            names[1] = "privatemessage".getHash();
        }

        blob_must_exist = false;
        target_player_slot = 1;
        minimum_parameter_count = 2;
        commandtype = Template;

        minimum_parameter_count = 2;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        string messagefrom = "pm from " + player.getUsername() + ": ";
        string message = "";
        for(int i = 2; i < tokens.length; i++)
        {
            message += tokens[i] + " ";
        }
        if(message != "")
        {
            sendClientMessage(this, target_player, messagefrom + message, SColor(255, 0, 0, 153));
            sendClientMessage(this, player, "Your message \" " + message + "\"has been sent");
            return false;
        }

        return true;
    }
}
//!ban "player" (minutes) - bans the player for 60 minutes by default, unless specified. 
class Ban : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "ban".getHash();
        }
        

        permlevel = pBan;
        
        blob_must_exist = false;
        target_player_slot = 1;
        minimum_parameter_count = 1;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CSecurity@ security = getSecurity();
        if(security.checkAccess_Feature(target_player, "ban_immunity"))
        {
            sendClientMessage(this, player, "This player has ban immunity");//Check for kick immunity    
            return false;
        }
        uint32 ban_length = 60;
        if (tokens.length > 2)
        {
            ban_length = parseInt(tokens[2]);
        }
        security.ban(target_player, ban_length);
        sendClientMessage(this, player, "Player " + target_player.getUsername() + " has been banned for " + ban_length + " minutes");//Check for ban immunity

        return true;
    }
}
//!unban "player" - unbans specified player with the specified username, as the player is not in the server autocomplete will not work. 
class Unban : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "unban".getHash();
        }
        
        
        blob_must_exist = false;
        permlevel = punBan;
        commandtype = Template;
        minimum_parameter_count = 1;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CSecurity@ security = getSecurity();
        /*if(security.isPlayerBanned(tokens[1]))
        {*/
            security.unBan(tokens[1]);
            sendClientMessage(this, player, "Player " + tokens[1] + " has been unbanned");
        /*}
        else
        {
            sendClientMessage(this, player, "Specified banned player not found, i.e nobody with this username is banned");
        }*///Fix me later numan

        return true;
    }
}
//!kickp "player" - kicks the player (from the server)
class Kick : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "kickp".getHash();//TODO, accept !kick and explain that they might be looking for !kickp
        }

        
        permlevel = pKick;
        commandtype = Template;

        blob_must_exist = false;
        target_player_slot = 1;
        minimum_parameter_count = 1;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(getSecurity().checkAccess_Feature(target_player, "kick_immunity"))
        {
            sendClientMessage(this, player, "This player has kick immunity");//Check for kick immunity    
            return false;
        }
        KickPlayer(target_player);
        sendClientMessage(this, player, "Player " + tokens[1] + " has been kicked");//Check for kick immunity

        return true;
    }
}
//!freeze "player" - will freeze a player ice cold if not frozen, if frozen it will unfreeze that player. The Effects of being subjected to freezing tempatures is not our problem.
class Freeze : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "freeze".getHash();
        }

        permlevel = pFreeze;
        commandtype = Template;
        
        blob_must_exist = false;
        target_player_slot = 1;
        minimum_parameter_count = 1;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(getSecurity().checkAccess_Feature(target_player, "freeze_immunity"))
        {
            sendClientMessage(this, player, "This player has freeze immunity");//Check for kick immunity    
            return false;
        }
        target_player.freeze = !target_player.freeze;

        return true;
    }
}
//!nextmap
class NextMap : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "nextmap".getHash();
        }
        

        active = false;//Command will not work.

        permlevel = Admin;

        blob_must_exist = false;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        LoadNextMap();

        return true;
    }
}
//!team "team" (player) - sets your own blobs to this, unless a player was specified.
class Team : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "team".getHash();
        }

        permlevel = Admin;
        commandtype = Template;
        
        if(tokens.length > 2)
        {
            blob_must_exist = false;
            target_player_slot = 2;
            target_player_blob_param = true;
        }
        else if (tokens.length == 1)
        {
            permlevel = 0;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.length == 1)
        {
            sendClientMessage(this, player, "Your controlled blob's team is " + blob.getTeamNum());
            return false;
        }

        // Picks team color from the TeamPalette.png (0 is blue, 1 is red, and so forth - if it runs out of colors, it uses the grey "neutral" color)
        int wanted_team = parseInt(tokens[1]);
        if (tokens.length > 2)
        {
            target_blob.server_setTeamNum(wanted_team);
        }
        else
        {
            blob.server_setTeamNum(wanted_team);
        }

        return true;
    }
}
//!playerteam "team" (player) - like !team but it sets the players team (in the scoreboard and on respawn generally), it does not change the blobs team
class PlayerTeam : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "playerteam".getHash();
        }

        permlevel = Admin;
        commandtype = Template;
        blob_must_exist = false;
        
        if(tokens.length > 2)
        {
            target_player_slot = 2;
        }
        else if(tokens.length == 1)
        {
            permlevel = 0;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.length == 1)
        {
            sendClientMessage(this, player, "Your player team is " + player.getTeamNum());
            return false;
        }

        // Picks team color from the TeamPalette.png (0 is blue, 1 is red, and so forth - if it runs out of colors, it uses the grey "neutral" color)
        int wanted_team = parseInt(tokens[1]);
        
        if (tokens.length > 2)
        { 	
            target_player.server_setTeamNum(wanted_team);
        }
        else
        {
            player.server_setTeamNum(wanted_team);
        }

        return true;
    }
}
//!changename "charactername" (player)
class ChangeName : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "changename".getHash();
        }
        

        commandtype = Template;
        blob_must_exist = false;
        minimum_parameter_count = 1;

        if(tokens.length > 2)
        {
            permlevel = Admin;
            target_player_slot = 2;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if (tokens.length > 2)
        {
            target_player.server_setCharacterName(tokens[1]);
        }
        else
        {
            player.server_setCharacterName(tokens[1]);
        }

        return true;
    }
}
//!teleport "player" - will teleport to that player || !teleport "player" "player2" - will teleport player to player2
class Teleport : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "teleport".getHash();
            names[1] = "tp".getHash();
        }
        

        target_player_slot = 1;
		target_player_blob_param = true;//This command requires the targets blob

        permlevel = Admin;
        commandtype = Template;
        minimum_parameter_count = 1;

        blob_must_exist = false;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.length > 2)
        {
            //if(target_player.isBot())
            //{
            //    sendClientMessage(this, player, "You can not teleport a bot.");
            //    return false;
            //}
            
            array<CPlayer@> target_players = getPlayersByShortUsername(tokens[2]);//Get a list of players that have this as the start of their name
            if(target_players.length() > 1)//If there is more than 1 player in the list
            {
                string playernames = "";
                for(int i = 0; i < target_players.length(); i++)//for every player in that list
                {
                    playernames += " : " + target_players[i].getUsername();// put their name in a string
                }
                sendClientMessage(this, player, "There is more than one possible player for the second player param" + playernames);//tell the client that these players in the string were found
                return false;//don't send the message to chat, don't do anything else
            }
            else if(target_players == null || target_players.length == 0)
            {
                sendClientMessage(this, player, "No player was found for the second player param.");
                return false;
            }

            CPlayer@ target_playertwo = target_players[0];
            
            if (target_playertwo !is null)
            {
                CBlob@ target_blobtwo = target_playertwo.getBlob();
                
                if(target_blobtwo != null && target_blob != null)
                {
                    Vec2f target_postwo = target_blobtwo.getPosition();
                    target_postwo.y -= 5;

                    CBitStream params;//Assign the params

                    params.write_u16(target_player.getNetworkID());
                    params.write_Vec2f(target_postwo);
                    this.SendCommand(this.getCommandID("teleport"), params);
                }
            }
            else
            {
                sendClientMessage(this, player, "The second specified player " + tokens[2] + " was not found");
            }
        }
        else 
        {
            if (blob == null)
            {
                sendClientMessage(this, player, "You cannot teleport your blob to this player as you have no blob.");
                return false;
            }
            Vec2f target_pos = target_blob.getPosition();
            target_pos.y -= 5;

            CBitStream params;//Assign the params
            
            params.write_u16(player.getNetworkID());
            params.write_Vec2f(target_pos);
            this.SendCommand(this.getCommandID("teleport"), params);
        }

        return true;
    }
}
//!coin "amount" (player) - gives coins you yourself unless a player was specified
class Coin : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "coin".getHash();
        }
        
        permlevel = Admin;
        commandtype = Template;
        blob_must_exist = false;
        minimum_parameter_count = 1;
        

        if(tokens.length > 2)//This command is optional
        {
            target_player_slot = 2;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        int coin = parseInt(tokens[1]);
        if (tokens.length > 2) 
        {
            target_player.server_setCoins(target_player.getCoins() + coin);
        }
        else
        {
            player.server_setCoins(player.getCoins() + coin);
        }	

        return true;
    }
}
//!damage "amount" (player) - Ouch!
class Damage : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "damage".getHash();
        }

        permlevel = Admin;
        commandtype = Template;
        minimum_parameter_count = 1;

        if(tokens.length > 2)
        {
            blob_must_exist = false;
            target_player_slot = 2;
            target_player_blob_param = true;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        float damage = parseFloat(tokens[1]);
        if(damage < 0.0)
        {
            sendClientMessage(this, player, "You can not apply negative damage");
            return false;
        }
        if (tokens.length > 2)
        { 
            target_blob.server_Hit(target_blob, target_blob.getPosition(), Vec2f(0, 0), damage, 0);
        }
        else
        {
            blob.server_Hit(blob, blob.getPosition(), Vec2f(0, 0), damage, 0);
        }
        return true;
    }
}
//!kill "player" - Destroys a player's blob. No refunds.
class Kill : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "kill".getHash();
        }

        permlevel = Admin;
        blob_must_exist = false;
        target_player_slot = 1;
        target_player_blob_param = true;
    
        minimum_parameter_count = 1;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        target_blob.server_Die();

        return true;
    }
}
//!morph "blob" (player) - turns yourself into the specified blob, unless a player was specified, this is good for class changing
class Morph : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "morph".getHash();
            names[1] = "playerblob".getHash();
            names[2] = "actor".getHash();
        }
        permlevel = Admin;
        commandtype = Template;
        minimum_parameter_count = 1;

        if(tokens.length > 2)
        {
            blob_must_exist = false;
            target_player_slot = 2;
            target_player_blob_param = true;
        }
    
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {//TODO: keep hp?
        string actor = tokens[1];
        
        if (tokens.length == 2) 
        {
            @target_player = @player;
            @target_blob = @blob; 
        }
            
        if(target_blob == null)
        {
            sendClientMessage(this, player, "Can not respawn while dead, try !forcerespawn \"player\"");
            return false;
        }
        CBlob@ newBlob = server_CreateBlob(actor, target_blob.getTeamNum(), target_blob.getPosition());
    
        if(newBlob != null && newBlob.getWidth() != 0.0f)
        {						
            if(target_blob != null) {
                target_blob.server_Die();
            }
            newBlob.server_SetPlayer(target_player);
            ParticleZombieLightning(target_blob.getPosition());
        }
        else
        {
            if(newBlob != null)
            {
                newBlob.server_Die();
            }
            sendClientMessage(this, player, "Failed to spawn the \"" + actor + "\" blob");
        }

        return true;
    }
}
//!addbot (on_player) (blob) (team) (name) (difficulty 1-15)
//- adds a bot as the specified blob, team, and name. Bot spawns on player pos. on_player = if true, spawns on player position. if false, respawns normally
class AddRobot : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "addbot".getHash();
            names[1] = "bot".getHash();
            names[2] = "createbot".getHash();
        }
        blob_must_exist = false;

        permlevel = Admin;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.length == 1)
        {
            CPlayer@ bot = AddBot("Henry");
        }
        else
        {
            bool on_player = true;
            string bot_actor = "";
            string bot_name = "Henry";
            u8 bot_team = 255;
            u8 bot_difficulty = 15;

            //There is at least 1 token.
            string sop_string = tokens[1];
            if(sop_string == "false" || sop_string == "0")
            {
                on_player = false;
            }
            //Are there two parameters?
            if (tokens.length > 2)
            {
                bot_actor = tokens[2];
            }
            //Three parameters?
            if(tokens.length > 3)
            {
                bot_team = parseInt(tokens[3]);
            }
            //Four parameters?
            if(tokens.length > 4)
            {
                bot_name = tokens[4];
            }
            //Five parameters?
            if(tokens.length > 5)
            {
                bot_difficulty = parseInt(tokens[5]);
            }

            if(on_player == true)
            {
                if(blob == null)
                {
                    sendClientMessage(this, player, "Your blob does not exist to let a blob spawn on you.");
                    return false;
                }
                if(bot_actor == "")
                {
                    bot_actor = "knight";
                }
                if(bot_team == 255)
                {
                    bot_team = 0;
                }

                CBlob@ newBlob = server_CreateBlob(bot_actor, bot_team, pos);   
                
                if(newBlob != null)
                {
                    newBlob.set_s32("difficulty", bot_difficulty);
                    newBlob.getBrain().server_SetActive(true);
                }
            }
            else
            {
                CPlayer@ bot = AddBot(bot_name);
            
                //bot.server_setSexNum(XORRandom(2));
                
                if(bot_team != 255)
                {
                    bot.server_setTeamNum(bot_team);
                }
                
                if(bot_actor != "")
                {
                    bot.lastBlobName = bot_actor;
                }
            }
        }

        return true;
    }
}
//!forcerespawn - respawns a player even if they already exist or are dead. Return from the dead.
class ForceRespawn : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "forcerespawn".getHash();
        }

        permlevel = Admin;
        if(tokens.length > 1)
        {
            blob_must_exist = false;
            target_player_slot = 1;
        }
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        if(tokens.length == 1)
        {
            @target_player = @player;
            @target_blob = @blob;
        }
        Vec2f[] spawns;
        Vec2f spawn;
        if (target_player.getTeamNum() == 0)
        {
            if(getMap().getMarkers("blue spawn", spawns))
            {
                spawn = spawns[ XORRandom(spawns.length) ];
            }
            else if(getMap().getMarkers("blue main spawn", spawns))
            {
                spawn = spawns[ XORRandom(spawns.length) ];
            }
            else
            {
                spawn = Vec2f(0,0);
            }
        }
        else if (target_player.getTeamNum() == 1)
        {
            if(getMap().getMarkers("red spawn", spawns))
            {
                spawn = spawns[ XORRandom(spawns.length) ];
            }
            else if(getMap().getMarkers("red main spawn", spawns))
            {
                spawn = spawns[ XORRandom(spawns.length) ];
            }
            else
            {
                spawn = Vec2f(0,0);
            }
        }
        else
        {
            spawn = Vec2f(0,0);
        }

        string actor = "knight";
        if(target_player.lastBlobName != "")
            actor = target_player.lastBlobName;
        CBlob@ newBlob = server_CreateBlob(actor, target_player.getTeamNum(), spawn);
            
        if(newBlob != null)
        {
            @target_blob = @target_player.getBlob();
            if(target_blob != null) {
                target_blob.server_Die();
            }
            newBlob.server_SetPlayer(target_player);
        }

        return true;
    }
}
//!give "blob" (amount) (player) - gives the specified blob to yourself or a specified player
class Give : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "give".getHash();
        }

        permlevel = Admin;
        minimum_parameter_count = 1;
        commandtype = Template;

        if(tokens.length > 3)
        {
            blob_must_exist = false;
            target_player_slot = 3;
            target_player_blob_param = true;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        int quantity = 1;

        if(tokens.length > 2)//If the quantity parameter is specified
        {
            quantity = parseInt(tokens[2]);
        }

        Vec2f _pos = pos;
        int8 _team = team;
        
        if (tokens.length > 3)//If the player parameter is specified
        {
            _pos = target_blob.getPosition();
            _team = target_blob.getTeamNum();
        }
        
        CBlob@ giveblob = server_CreateBlobNoInit(tokens[1]);
        
        giveblob.server_setTeamNum(_team);
        giveblob.setPosition(_pos);
        giveblob.Init();


        if(giveblob.getMaxQuantity() > 1)
        {
            giveblob.Tag('custom quantity');

            giveblob.server_SetQuantity(quantity);
        }

        return true;
    }
}
//!sethp "amount" (player) - sets your own hp to the amount specified unless a player was specified.
class SetHp : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "sethp".getHash();
        }

        permlevel = Admin;

        minimum_parameter_count = 1;

        commandtype = Template;

        if(tokens.length > 2)
        {
            blob_must_exist = false;
            target_player_slot = 2;
            target_player_blob_param = true;
        }
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        float health = parseFloat(tokens[1]);
        if (tokens.length > 2) 
        { 
            target_blob.server_SetHealth(health);
        }
        else if (blob != null)
        {
            blob.server_SetHealth(health);
        }

        return true;
    }
}

class CommandCount : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "commandcount".getHash();
        }
        
        blob_must_exist = false;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        array<ICommand@> commands;
        this.get("ChatCommands", commands);

        sendClientMessage(this, player, "There are " + commands.size() + " commands");
        //TODO tell active commands.
        //TODO tell commands that this user can use  (check each one's security)
        return true;
    }
}

class Lantern : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)
        {
            names[0] = "lantern".getHash();
        }
        minimum_parameter_count = 4;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        CBlob@ lantern = server_CreateBlob("lantern",blob.getTeamNum(),blob.getPosition());
        CBitStream params;
        params.write_u16(lantern.getNetworkID());
        params.write_u8(parseInt(tokens[1]));
        params.write_u8(parseInt(tokens[2]));
        params.write_u8(parseInt(tokens[3]));
        params.write_u8(parseInt(tokens[4]));

        this.SendCommand(this.getCommandID("lantern"),params);

        return true;
    }
}

//Template
/*
class Input_Name_Here : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        if(names[0] == 0)//Happens only once
        {
            names[0] = "Input_Name_Here".getHash();
        }

        permlevel = Admin;//Requires adminship
        
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        //Code when the command runs happens here
        return true;
    }
}
*/