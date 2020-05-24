//See the !test command if you want to make your own command. Search for !test.


//TODO
// mute player command
//Turn all commands into methods to allow other commands to use each other and the ability to take out commands for use in other mods.
//Have an onTick method that runs commands by the amount of delay they requested. i.e a single tick of delay for spawning bots to allow them to be spawned with a blob.
//Clean up AddBot

//!timespeed SPEED

//!permissionlist             for checking security permissions

//!getplayerroles (PLAYERNAME)

//!tagplayer - tag the CPlayer

//!playerlist

//!playerid's

//!kickid
//!banid

//Symbols. For example. @closest @furthest

//A confirmation that lays out the params, and allows you to either ignore it, or type !y or !yes to confirm the command

//Tagging only tags server side, probably do both client and server side.

//New help menu, preferably interactive. Button for all commands you can use, button for each perm level of commands.

//!actor, but don't kill the old blob

//!addscript (true for all clients and server. false for server only) SCRIPT (CLASS) (IDENTIFIER, if needed)
//not specifying the class defaults to a player's blob
//!addscript true examplescript.as cblob 125
//!addscript true examplescript.as the1sad1numanator
//!addscript true examplescript.as cmap
//!addscript true examplescript.as csprite 125
//Remember to return the bool back to the chat to inform if it worked or not.


//!gettag 
//Just like !tagblob but instead getting the value

//!setheadnum USERNAME HEADNUMBER
//!setsex USERNAME BOY||GIRL

//!killall blobname - Kills all of a single blob

//Super admin can disable or enable certain commands.

//Blacklisted blobs

//!radiusmessage {radius} {content

//!tp (insert location) i.e |red spawn| |blue spawn| |void(y9999)| |etc|

//!emptyinventory || !destroyinventory

//!addtoinventory {blob} (amount) (player)

#include "MakeSeed.as";
#include "MakeCrate.as";
#include "MakeScroll.as";

bool ExtraCommands = true;//Make this false if you want all the new commands to be disabled. But why would you?

array<ICommand@> commands =
{
    AllMats(),
	WoodStone(),
	StoneWood(),
	Wood(),
	Stones(),
	Gold(),
	Tree(),
	BTree(),
	AllArrows(),
	Arrows(),
	AllBombs(),
	Bombs(),
	SpawnWater(),
	Seed(),
	Crate(),
	Scroll(),
	FishySchool(),
	ChickenFlock(),
	//ExtraCommands below here
    HideCommands(),
	ShowCommands(),
	PlayerCount(),
	//NextMap(),
	SpinEverything(),
    Test(),
	GiveCoin(),
    PrivateMessage(),
	SetTime(),
	Ban(),
    Unban(),
	Kick(),
	Freeze(),
	Teleport(),
	Coin(),
	SetHp(),
	Damage(),
	Kill(),
	Team(),
	PlayerTeam(),
	ChangeName(),
	Morph(),
    AddRobot(),
	ForceRespawn(),
	Give(),
    TagBlob(),
    TagPlayerBlob(),
    HeldBlobNetID(),
    PlayerBlobNetID(),
    PlayerNetID(),
    Announce(),
    CommandCount()//End
};

enum CommandType//For the interactive help menu (todo)
{
    Debug = 1,
    Testing,
    Legacy,
    Template,
    TODO,
    Info,
}

enum PermissionLevel
{
    Moderator = 1,
    Admin,
    SuperAdmin,
    pBan,
    punBan,
    pKick,
    pFreeze,
}

interface ICommand
{
    void Setup(string[]@ tokens);

    void RefreshVars();
    
    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob);

    bool isActive();
    void setActive(bool value);

    string inGamemode();
    void setGamemode(string value);

    array<int> get_Names();
    void set_Names(array<int> value);
    
    u16 get_PermLevel();
    void set_PermLevel(u16 value);

    u16 get_CommandType();
    void set_CommandType(u16 value);
    
    u8 get_TargetPlayerSlot();
    void set_TargetPlayerSlot(u8 value);
    
    bool get_TargetPlayerBlobParam();
    void set_TargetPlayerBlobParam(bool value);

    bool get_NoSvTest();
    void set_NoSvTest(bool value);

    bool get_BlobMustExist();
    void set_BlobMustExist(bool value);

    u8 get_MinimumParameterCount();
    void set_MinimumParameterCount(u8 value);

}

class CommandBase : ICommand
{
    void Setup(string[]@ tokens)
    {
        error("SETUP METHOD NOT FOUND!");
    }

    void RefreshVars()
    {
        permlevel = 0;
        commandtype = 0;
        target_player_slot = 0;
        target_player_blob_param = true;
        no_sv_test = false;
        blob_must_exist = true;
        minimum_parameter_count = 0;
    }
    
    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob)
    {
        error("COMMANDCODE METHOD NOT FOUND!");
        return false;
    }

    private bool active = true;//If this is false, this command is disabled and unusable.
    bool isActive() { return active; }
    void setActive(bool value) { active = value; }

    private string in_gamemode = "";
    string inGamemode(){ return in_gamemode; }
    void setGamemode(string value) { in_gamemode = value; }

    private array<int> names(4);
    array<int> get_Names() { return names; }
    void set_Names(array<int> value) { names = value; }

    private u16 permlevel = 0;//The role/permission required to use this command. 0 is nothing.
    u16 get_PermLevel(){ return permlevel; }
    void set_PermLevel(u16 value) { permlevel = value; }

    private u16 commandtype = 0;
    u16 get_CommandType() { return commandtype; }
    void set_CommandType(u16 value){ commandtype = value; }

    private u8 target_player_slot = 0;
    u8 get_TargetPlayerSlot() { return target_player_slot;}
    void set_TargetPlayerSlot(u8 value) { target_player_slot = value; }

    private bool target_player_blob_param = true;
    bool get_TargetPlayerBlobParam() { return target_player_blob_param; }
    void set_TargetPlayerBlobParam(bool value) { target_player_blob_param = value; }

    private bool no_sv_test = false;//All commands besides those specified with no_sv_test = true; can be used when sv_test is 1.
    bool get_NoSvTest() { return no_sv_test; }
    void set_NoSvTest(bool value) { no_sv_test = value; }

    private bool blob_must_exist = true;//If this is true, when the player's blob does not exist the command code will not run and the player will be informed that their blob is null.
    bool get_BlobMustExist() { return blob_must_exist; }
    void set_BlobMustExist(bool value) { blob_must_exist = value; }

    private u8 minimum_parameter_count = 0;//The minimum amount of parameters that must be used in this command.
    u8 get_MinimumParameterCount() { return minimum_parameter_count; }
    void set_MinimumParameterCount(u8 value) { minimum_parameter_count = value; }
}

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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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

        return false;
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
        commandtype = TODO;
        names[0] = "commands".getHash();
        names[1] = "showcommands".getHash();
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
        blob_must_exist = true;
        commandtype = Debug;
        names[0] = "heldblobnetid".getHash();
        names[1] = "heldblobid".getHash();
        names[2] = "heldid".getHash();
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
        commandtype = Debug;
        names[0] = "playerid".getHash();
        names[1] = "playernetid".getHash();
        
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
        names[0] = "playerblobnetid".getHash();
        names[1] = "playerblobid".getHash();

        commandtype = Debug;
        
        if(tokens.size() > 1)
        {
            target_player_slot = 1;
            target_player_blob_param = true;
        }
        else
        {
            blob_must_exist = true;
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
        commandtype = Info;
        names[0] = "playercount".getHash();
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
        names[0] = "announce".getHash();

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
        names[0] = "tagplayerblob".getHash();

        permlevel = Admin;
        minimum_parameter_count = 3;
        commandtype = Debug;

        if(tokens.size() > 4)
        {
            target_player_slot = 4;
            target_player_blob_param = true;
        }
        else
        {
            blob_must_exist = true;
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
        names[0] = "tagblob".getHash();

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
        names[0] = "hidecommands".getHash();
        
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
            hidecom = true;
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
        names[0] = "spineverything".getHash();

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
        names[0] = "settime".getHash();

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
        names[0] = "givecoin".getHash();

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
        names[0] = "pm".getHash();
        names[1] = "privatemessage".getHash();

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
        names[0] = "ban".getHash();

        permlevel = pBan;
        
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
        names[0] = "unban".getHash();
        
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
        names[0] = "kickp".getHash();//TODO, accept !kick and explain that they might be looking for !kickp

        permlevel = pKick;
        commandtype = Template;

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
        names[0] = "freeze".getHash();

        permlevel = pFreeze;
        commandtype = Template;
        
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
        names[0] = "nextmap".getHash();

        active = false;//Command will not work.

        permlevel = Admin;

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
        names[0] = "team".getHash();

        permlevel = Admin;
        commandtype = Template;
        
        if(tokens.length > 2)
        {
            target_player_slot = 2;
            target_player_blob_param = true;
        }
        else if(tokens.length > 1)
        {
            blob_must_exist = true;
        }
        else
        {
            permlevel = 0;
            blob_must_exist = true;
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
        names[0] = "playerteam".getHash();

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
        names[0] = "changename".getHash();

        commandtype = Template;
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
        names[0] = "teleport".getHash();
        names[1] = "tp".getHash();

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
        else if (blob != null)
        {
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
        names[0] = "coin".getHash();

        permlevel = Admin;
        commandtype = Template;
        minimum_parameter_count = 1;

        if(tokens.length > 2)//This command is optional
        {
            blob_must_exist = false;
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
        names[0] = "damage".getHash();

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
        else if (blob != null)
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
        permlevel = Admin;
        target_player_slot = 1;
        target_player_blob_param = true;
    
        minimum_parameter_count = 1;
        commandtype = Template;
        names[0] = "kill".getHash();
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
        
        if (tokens.length > 2) 
        {
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
                sendClientMessage(this, player, "Failed to spawn the \"" + actor + "\" blob");
            }
        }
        else
        {
            if(blob == null)
            {
                sendClientMessage(this, player, "Can not respawn while dead, try !forcerespawn \"player\"");
                return false;
            }
            CBlob@ newBlob = server_CreateBlob(actor, team, pos);
            if(newBlob != null && newBlob.getWidth() != 0.0f)
            {
                if(blob != null)
                { 
                    blob.server_Die();
                }
                newBlob.server_SetPlayer(player);
                ParticleZombieLightning(pos); 
            }
            else
            {
                sendClientMessage(this, player, "Failed to spawn the \"" + actor + "\" blob");
            }
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
        names[0] = "addbot".getHash();
        names[1] = "bot".getHash();
        names[2] = "createbot".getHash();

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
        names[0] = "forcerespawn".getHash();

        permlevel = Admin;
        if(tokens.length > 1)
        {
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
        names[0] = "give".getHash();

        permlevel = Admin;
        minimum_parameter_count = 1;
        commandtype = Template;
        blob_must_exist = true;

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
        names[0] = "sethp".getHash();

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
        names[0] = "commandcount".getHash();
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        sendClientMessage(this, player, "There are " + commands.size() + " commands");
        //TODO tell active commands.
        return true;
    }
}

//Template
/*
class  : CommandBase
{
    void Setup(string[]@ tokens) override
    {
        names[0] = "".getHash();
        permlevel = Admin;
        commandtype = Template;
    }

    bool CommandCode(CRules@ this, string[]@ tokens, CPlayer@ player, CBlob@ blob, Vec2f pos, int team, CPlayer@ target_player, CBlob@ target_blob) override
    {
        
        return true;
    }
}
*/












void onInit(CRules@ this)
{
	this.addCommandID("clientmessage");	
	this.addCommandID("teleport");
    this.addCommandID("clientshowhelp");
	this.addCommandID("allclientshidehelp");
    this.addCommandID("announcement");
}

bool onServerProcessChat(CRules@ this, const string& in _text_in, string& out text_out, CPlayer@ player)
{
	//--------MAKING CUSTOM COMMANDS-------//
	// Inspect the !test command
    // It will show you the basics
    // Inspect the commented out !playercount command if you desire a more barebones command. 

	if (player is null)
    {
        error("player was somehow null");
		return true;
    }

	CBlob@ blob = player.getBlob(); // now, when the code references "blob," it means the player who called the command

	//if (blob is null && !player.isMod())
	//{
	//	return true;
	//}
	Vec2f pos;
	int team;
	if (blob !is null)
	{
		pos = blob.getPosition(); // grab player position (x, y)
		team = blob.getTeamNum(); // grab player team number (for i.e. making all flags you spawn be your team's flags)
	}

    string text_in;
    /*if(blob != null)
    {
        text_in = atFindAndReplace(blob.getPosition(), _text_in);
        text_out = text_in;
    }
    else
    {*/
        text_in = _text_in;
    //}

    if(text_in.substr(0, 1) != "!")
    {
        return true;
    }














	
	if (text_in == "!debug" && player.isMod())
	{
		// print all blobs
		CBlob@[] all;
		getBlobs(@all);

		for (u32 i = 0; i < all.length; i++)
		{
			CBlob@ blob = all[i];
			print("[" + blob.getName() + " " + blob.getNetworkID() + "] ");
		}
	}


    

    print("text_in = " + text_in);
    string[]@ tokens = (text_in.substr(1, text_in.size())).split(" ");

    ICommand@ command = @null;

    for(u16 p = 0; p < commands.size(); p++)
    {
        commands[p].RefreshVars();
        commands[p].Setup(tokens);
        array<int> _names = commands[p].get_Names(); 
        if(_names.size() == 0)
        {
            error("A command did not have a name to go by");
            return false;
        }
        for(u16 name = 0; name < _names.size(); name++)
        {
            if(_names[name] == tokens[0].getHash())
            {
                if(!commands[p].isActive() && !getSecurity().checkAccess_Command(player, "ALL"))//If the command is not active and the player isn't a superadmin
                {
                    sendClientMessage(this, player, "This command is not active.");
                    return !this.get_bool(player.getUsername() + "_hidecom");
                }
                print("token length = " + tokens.size());
                @command = @commands[p];
                break;
            }
        }
        if(command != null)
        {
            break;
        }
    }


    if(command == null && (sv_test || getSecurity().checkAccess_Command(player, "admin_color")))//If this isn't a command and either sv_test is on or the player is an admin.
    {
        string name = text_in.substr(1, text_in.size());
        if(blob != null)
        {
            server_CreateBlob(name, team, pos);
        }
        return !this.get_bool(player.getUsername() + "_hidecom");
    }

    if(command == null)
    {
        return !this.get_bool(player.getUsername() + "_hidecom");
    }


    if(command.get_BlobMustExist())
    {
        if(blob == null)
        {
            sendClientMessage(this, player, "Your blob appears to be null, this command will not work unless your blob actually exists.");
            return !this.get_bool(player.getUsername() + "_hidecom");
        }
    }

    if(command.get_NoSvTest())
    {
        sv_test = false;
    }   

    u8 permlevel;//what level of adminship you need to use this command
    permlevel = command.get_PermLevel();

    if(permlevel == Moderator && !player.isMod() && !sv_test)
    {
        sendClientMessage(this, player, "You must be a moderator or higher to use this command.");
        return true;
    }
    if(permlevel == Admin && !getSecurity().checkAccess_Command(player, "admin_color") && !sv_test)
    {
        sendClientMessage(this, player, "You must be a admin or higher to use this command.");
        return true;
    }
    if(permlevel == SuperAdmin && !getSecurity().checkAccess_Command(player, "ALL") && !sv_test)
    {
        sendClientMessage(this, player, "You must be a superadmin to use this command.");
        return true;
    }
    if(permlevel == pFreeze && (!getSecurity().checkAccess_Command(player, "freezeid") || !getSecurity().checkAccess_Command(player, "unfreezeid")))
    {
        sendClientMessage(this, player, "You do not sufficient permissions to freeze and unfreeze a player.");
        return true;
    }
    if(permlevel == pKick && !getSecurity().checkAccess_Command(player, "kick"))
    {
        sendClientMessage(this, player, "You do not sufficient permissions to kick a player.");
        return true;
    }
    if(permlevel == punBan && !getSecurity().checkAccess_Command(player, "unban")){
        sendClientMessage(this, player, "You do not sufficient permissions to unban a player.");
        return true;
    }
    if(permlevel == pBan && !getSecurity().checkAccess_Command(player, "ban")){
        sendClientMessage(this, player, "You do not sufficient permissions to ban a player.");
        return true;
    }


    if(tokens.size() < command.get_MinimumParameterCount() + 1)
    {
        sendClientMessage(this, player, "This command requires at least " + command.get_MinimumParameterCount() + " parameters.");
        return !this.get_bool(player.getUsername() + "_hidecom");
    }

    //Assign needed values

    CPlayer@ target_player;
    CBlob@ target_blob;

    if(command.get_TargetPlayerSlot() != 0)
    {
        if(!getAndAssignTargets(this, player, tokens, command.get_TargetPlayerSlot(), command.get_TargetPlayerBlobParam(), target_player, target_blob))
        {
            return false;
        }
    }		

    if(command.CommandCode(this, tokens, player, blob, pos, team, target_player, target_blob))
    {
        return !this.get_bool(player.getUsername() + "_hidecom");//If hidecom is true, chat will not be showed. See !hidecommands
    }
    else
    {
        return false;//returning false prevents the message from being sent to chat.
    }

    //return !this.get_bool(player.getUsername() + "_hidecom");

	return true;//Returning sends message to chat
}

void onCommand( CRules@ this, u8 cmd, CBitStream @params )
{
    if(cmd == this.getCommandID("clientmessage") )//sends message to a specified client
    {
        
		string text = params.read_string();
        u8 alpha = params.read_u8();
        u8 red = params.read_u8();
        u8 green = params.read_u8();
        u8 blue = params.read_u8();


        client_AddToChat(text, SColor(alpha, red, green, blue));//Color of the text
    }
	else if(cmd == this.getCommandID("teleport") )//teleports player to other player
	{
		CPlayer@ target_player = getPlayerByNetworkId(params.read_u16());//Player 1
		
		if(target_player == null) //|| !target_player.isMyPlayer())//Not sure if this is needed
		{	return;	}
		

		CBlob@ target_blob = target_player.getBlob();
		if(target_blob != null)
		{
            Vec2f pos = params.read_Vec2f();
			target_blob.setPosition(pos);
            ParticleZombieLightning(pos);
        }
		
	}
    else if(cmd == this.getCommandID("clientshowhelp"))//toggles the gui help overlay
    {
		if(!isClient())
		{
			return;
		}
        CPlayer@ local_player = getLocalPlayer();
        if(local_player == null)
        {
            return;
        }

		if(this.get_bool(local_player.getNetworkID() + "_showHelp") == false)
		{
			this.set_bool(local_player.getNetworkID() + "_showHelp", true);
			client_AddToChat("Showing Commands, type !commands to hide", SColor(255, 255, 0, 0));
		}
		else
		{
			this.set_bool(local_player.getNetworkID() + "_showHelp", false);
			client_AddToChat("Hiding help", SColor(255, 255, 0, 0));
		}
	}
	else if(cmd == this.getCommandID("allclientshidehelp"))//hides all gui help overlays for all clients
	{
		if(!isClient())
		{
			return;
		}

		CPlayer@ target_player = getLocalPlayer();
		if (target_player != null)
		{
			if(this.get_bool(target_player.getNetworkID() + "_showHelp") == true)
			{
				this.set_bool(target_player.getNetworkID() + "_showHelp", false);
			}
		}
	}
    else if(cmd == this.getCommandID("announcement"))
	{
		this.set_string("announcement", params.read_string());
		this.set_u32("announcementtime",30 * 15 + getGameTime());//15 seconds
	}
}

void sendClientMessage(CRules@ this, CPlayer@ player, string message)
{
	CBitStream params;//Assign the params
	params.write_string(message);
    params.write_u8(255);
    params.write_u8(255);
    params.write_u8(0);
    params.write_u8(0);

	this.SendCommand(this.getCommandID("clientmessage"), params, player);
}
void sendClientMessage(CRules@ this, CPlayer@ player, string message, SColor color)//Now with color
{
	CBitStream params;//Assign the params
	params.write_string(message);
    params.write_u8(color.getAlpha());
    params.write_u8(color.getRed());
    params.write_u8(color.getGreen());
    params.write_u8(color.getBlue());

	this.SendCommand(this.getCommandID("clientmessage"), params, player);
}

void onRestart( CRules@ this )
{
    this.set_u32("announcementtime", 0);
}

void onRender( CRules@ this )
{
    if(!isClient())
    {
        return;
    }

    CPlayer@ localplayer = getLocalPlayer();
    if(localplayer == null)
    {
        return;
    }

    if(this.get_u32("announcementtime") > getGameTime())
	{
		GUI::DrawTextCentered(this.get_string("announcement"), Vec2f(getScreenWidth()/2,getScreenHeight()/2), SColor(255,255,127,60));
	}


    if(this.get_bool(localplayer.getNetworkID() + "_showHelp") == false)
    {
        return;
    }
	u8 nextline = 16;
	
	GUI::SetFont("menu");
    Vec2f drawPos = Vec2f(getScreenWidth() - 350, 0);
    Vec2f drawPos_width = Vec2f(drawPos.x + 346, drawPos.y);
    GUI::DrawText("Commands parameters:\n" + 
	"{} <- Required\n" + 
    "[] <- Optional" +
    "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" + 
    "Type !commands to close this window"
    ,
    drawPos, drawPos_width, color_black, false, false, true);
        
    GUI::DrawText("                             :No Roles:\n" +
    "!playercount - Tells you the playercount\n" +
    "!givecoin {amount} {player}\n" +
    "-Deducts coin from you to give to another player\n" +
    "!pm {player} {message}\n" + 
    "- Privately spam player of choosing\n" +
    "!changename {charactername} [player]\n" +
    "- To change another's name, you require admin"
    ,
    Vec2f(drawPos.x, drawPos.y - 7 + nextline * 4), drawPos_width, SColor(255, 255, 125, 10), false, false, false);
    
    GUI::DrawText("                             :Moderators:\n" +
    "!ban {player} [minutes] - Defaults to 60 minutes\n" +
    "Warning, this command auto completes names\n" +
    "!unban {player} - Auto complete will not work\n" +
    "!kickp {player}\n" +
    "!freeze {player} - Use again to unfreeze\n" +
    "!team {team} [player] - Blob team\n" +
    "!playerteam {team} [player] - Player team"
    ,
    Vec2f(drawPos.x, drawPos.y + nextline * 11), drawPos_width, SColor(255, 45, 240, 45), false, false, false);
    
    GUI::DrawText("                             :Admins:\n" +
    "!teleport {player} - Teleports you to the player\n" +
    "!teleport {player1} {player2}\n" +
    "- Teleports player1 to player2\n" +
    "!coin {amount} [player] - Coins appear magically\n" +
    "!sethp {amount} [player] - give yourself 9999 life\n" +
    "!damage {amount} [player] - Hurt their feelings\n" + 
    "!kill {player} - Makes players ask, \"why'd i die?\"\n" +
    "!actor {blob} [player]\n" +
    "-This changes what blob the player is controlling\n" +
    "!forcerespawn {player}\n" +
    "- Drags the player back into the living world\n" +
    "!give {blob} [quantity] [player]\n" +
    "- Spawns a blob on a player\n" +
    "Quantity only relevant to quantity-based blobs\n" +
    "!announce {text}\n" +
    "!addbot [on_player] [blob] [team] [name] [exp]\n" +
    "- ex !addbot true archer 1\n" +
    "On you, archer, team 1\n"+
    "exp=difficulty. Choose a value between 0 and 15"
    ,
    Vec2f(drawPos.x, drawPos.y - 5 + nextline * 20), drawPos_width, SColor(255, 25, 25, 215), false, false, false);

    GUI::DrawText("                             :SuperAdmin:\n" +
    "!settime {time} input between 0.0 - 1.0\n" +
    "!spineverything - go ahead, try it\n" +
    "!hidecommands - hide your admin-abuse\n" +
    "!togglefeatures- turns off/on these commands"
    ,
    Vec2f(drawPos.x, drawPos.y - 3 + nextline * 40), drawPos_width, SColor(255, 235, 0, 0), false, false, false);
}

//Get an array of players that have "shortname" at the start of their username. If their username is exactly the same, it will return an array containing only that player.
array<CPlayer@> getPlayersByShortUsername(string shortname)
{
    array<CPlayer@> playersout;//The main array for storing all the players which contain shortname

    for(int i = 0; i < getPlayerCount(); i++)//For every player
    {
        CPlayer@ player = getPlayer(i);//Grab the player
        string playerusername = player.getUsername();//Get the player's username

        if(playerusername == shortname)//If the name is exactly the same
        {
            array<CPlayer@> playersoutone;//Make a quick array
            playersoutone.push_back(player);//Put the player in that array
            return playersoutone;//Return this array
        }

        if(playerusername.substr(0, shortname.length()) == shortname)//If the players username contains shortname
        {
            playersout.push_back(player);//Put the array.
        }
    }
    return playersout;//Return the array
}

//Uses the above getPlayersByShortUsername method.
CPlayer@ getPlayerByShortUsername(string shortname)
{
    array<CPlayer@> target_players = getPlayersByShortUsername(shortname);//Get a list of players that have this as the start of their username
    if(target_players.length() > 1)//If there is more than 1 player in the list
    {
        string playernames = "";
        for(int i = 0; i < target_players.length(); i++)//for every player in that list
        {
            playernames += " : " + target_players[i].getUsername();//put their name in a string
        }
        print("There is more than one possible player for the player param" + playernames);//tell the client that these players in the string were found
        return @null;//don't send the message to chat, don't do anything else
    }
    else if(target_players == null || target_players.length == 0)
    {
        print("No player was found for the player param.");
        return @null;
    }
    return target_players[0];
}


bool onClientProcessChat(CRules@ this, const string& in text_in, string& out text_out, CPlayer@ player)
{
	if (text_in == "!debug" && !getNet().isServer())
	{
		// print all blobs
		CBlob@[] all;
		getBlobs(@all);

		for (u32 i = 0; i < all.length; i++)
		{
			CBlob@ blob = all[i];
			print("[" + blob.getName() + " " + blob.getNetworkID() + "] ");

			if (blob.getShape() !is null)
			{
				CBlob@[] overlapping;
				if (blob.getOverlapping(@overlapping))
				{
					for (uint i = 0; i < overlapping.length; i++)
					{
						CBlob@ overlap = overlapping[i];
						print("       " + overlap.getName() + " " + overlap.isLadder());
					}
				}
			}
		}
	}

	return true;
}

string TagSpecificBlob(CBlob@ targetblob, string typein, string namein, string input)
{
    if(targetblob == null)
    {
        return "something weird happened when assigning tags";
    }

    if(typein == "u8")
    {
        u8 innum = parseInt(input);
        targetblob.set_u8(namein, innum);
    }
    else if(typein == "s8")
    {
        s8 innum = parseInt(input);
        targetblob.set_s8(namein, innum);
    }
    else if(typein == "u16")
    {
        u16 innum = parseInt(input);
        targetblob.set_u16(namein, innum);
    }
    else if(typein == "s16")
    {
        s16 innum = parseInt(input);
        targetblob.set_s16(namein, innum);
    }
    else if(typein == "u32")
    {
        u32 innum = parseInt(input);
        targetblob.set_u32(namein, innum);
    }
    else if(typein == "s32")
    {
        s32 innum = parseInt(input);
        targetblob.set_s32(namein, innum);
    }
    else if(typein == "f32")
    {
        float innum = parseFloat(input);
        targetblob.set_f32(namein, innum);
    }
    else if(typein == "bool")
    {
        
        if (input == "true" || input == "1")
        {
            targetblob.set_bool(namein, true);
        }
        else if (input == "false" || input == "0")
        {
            targetblob.set_bool(namein, false);
        }
        else
        {
            return "True or false, it isn't that hard";
        }
    }
    else if(typein == "string")
    {
        targetblob.set_string(namein, input);
    }
    else if(typein == "tag")
    {
        if(input == "true" || input == "1")
        {
            targetblob.Tag(namein);
        }
        else if (input == "false" || input == "0")
        {
            targetblob.Untag(namein);
        }
        else
        {
            return "Set the value to true, to tag. Set the value to false, to untag.";
        }
    }
    else
    {
        return "typein " + typein + " is not one of the types you can use.";
    }

    targetblob.Sync(namein, true);
    
    return "";
}


//When getting blobs, returns netid's
//When getting players, returns usernames
string atFindAndReplace(Vec2f point, string text_in)
{
    string text_out;
    string[]@ tokens = text_in.split(" ");
    for(u16 q = 0; q < tokens.length(); q++)
    {
        if(tokens[q].substr(0,1) == "@")
        {
            string _str = tokens[q].substr(1, tokens[q].length());
            if(_str == "closeplayer" || _str == "closep")
            {
                CPlayer@ target_player = SortPlayersByDistance(point, 99999999)[1];
                if(target_player != null)
                {
                    print("check 1");
                    _str = target_player.getUsername();
                }
            }
            else if( _str == "farplayer" || _str == "farp")
            {
                print("farp, hehe");
                
            }
            else if( _str == "closeblob" || _str == "closeb")
            {

            }
            else if( _str == "farblob" || _str == "farb")
            {
                
            }

            tokens[q] = _str;
        }


        string _space = " ";
        if(q == 0){ _space = ""; }

        text_out += _space + tokens[q];
    }
    //print(text_out);
    return text_out;
}

array<CPlayer@> SortPlayersByDistance(Vec2f point, f32 radius)
{
    array<CBlob@> playerblobs(getPlayerCount());
    array<CPlayer@> closestplayers(getPlayerCount());
    
    for(uint i = 0; i < playerblobs.length(); i++)
    {
        CPlayer@ _player = getPlayer(i);
        if(_player != null)
        {
            @playerblobs[i] = @_player.getBlob();
        }
    }

    array<f32> blob_dist(closestplayers.length, 99999999);
    for (uint step = 0; step < getPlayerCount(); step++)
    {





        if(playerblobs[step] == null)
        {
            continue;
        }
        for(u16 i = 0; i < playerblobs.length; i++)
        {

            for(u16 q = 0; q < closestplayers.length; q++)
            {
                print("step = " + step + "\ni = " + i + "\nq = " + q);

                Vec2f tpos = playerblobs[step].getPosition();
                f32 dist = (tpos - point).getLength();
                blob_dist[step] = dist;
                if (dist < blob_dist[q])
                {
                    @closestplayers[q] = @playerblobs[step].getPlayer();
                }   
            }

        }
    }
    
    return closestplayers;
}

bool getAndAssignTargets(CRules@ this, CPlayer@ player, string[]@ tokens, u8 target_player_slot, bool target_player_blob_param, CPlayer@ &out target_player, CBlob@ &out target_blob)
{
    if(tokens.length <= target_player_slot)
    {
        sendClientMessage(this, player, "You must specify the player on param " + target_player_slot);
        return false;
    }

    array<CPlayer@> target_players = getPlayersByShortUsername(tokens[target_player_slot]);//Get a list of players that have this as the start of their name
    if(target_players.length() > 1)//If there is more than 1 player in the list
    {
        string playernames = "";
        for(int i = 0; i < target_players.length(); i++)//for every player in that list
        {
            playernames += " : " + target_players[i].getUsername();// put their name in a string
        }
        sendClientMessage(this, player, "There is more than one possible player" + playernames);//tell the client that these players in the string were found
        return false;//don't send the message to chat, don't do anything else
    }
    else if(target_players == null || target_players.length == 0)
    {
        sendClientMessage(this, player, "No players were found from " + tokens[target_player_slot]);
        return false;
    }

    
    @target_player = target_players[0];

    if (target_player != null)
    {
        if(target_player_blob_param == true)
        {
            if(target_player.getBlob() == null)
            {
                sendClientMessage(this, player, "This player does not yet have a blob.");
                return false;
            }
            @target_blob = @target_player.getBlob();
        }
    }
    else
    {
        sendClientMessage(this, player, "player " + tokens[target_player_slot] + " not found");
        return false;
    }

    return true;
}

/*CPlayer@ findNearestPlayer(bool skipclosest, Vec2f point, f32 radius)
{
    u16 find_closest_count = 2;
    array<CBlob@> playerblobs(getPlayerCount());
    array<CPlayer@> closestplayers(find_closest_count);
    
    for(uint i = 0; i < playerblobs.length(); i++)
    {
        CPlayer@ _player = getPlayer(i);
        if(_player != null)
        {
            @playerblobs[i] = @_player.getBlob();
        }
    }

    array<f32> best_dist(closestplayers.length, 99999999);
    for (uint step = 0; step < playerblobs.length; ++step)
    {
        print("step = " + step);
        if(playerblobs[step] == null)
        {
            continue;
        }

        for(u16 i = 0; i < closestplayers.length; i++)
        {
            Vec2f tpos = playerblobs[step].getPosition();
            f32 dist = (tpos - point).getLength();
            if (dist < best_dist[i])
            {
                @closestplayers[i] = @playerblobs[step].getPlayer();
                best_dist[i] = dist;
                break;
            }   
        }
    }

    if(skipclosest)
    {
        return closestplayers[1];
    }
    
    return closestplayers[0];
}*/