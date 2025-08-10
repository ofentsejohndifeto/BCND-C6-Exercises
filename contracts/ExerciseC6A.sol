pragma solidity ^0.5.0;

contract ExerciseC6A {

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/

    struct UserProfile {
        bool isRegistered;
        bool isAdmin;
    }

    address private contractOwner;                  // Account used to deploy contract
    mapping(address => UserProfile) private userProfiles;   // Mapping for storing user profiles

    bool private operational = true; // Bool variable for operational control

    uint constant M = 2;

    address[] multiCalls = new address[](0);

    /********************************************************************************************/
    /*                                       EVENT DEFINITIONS                                  */
    /********************************************************************************************/

    // No events (you may want to add some later for tracking)

    /********************************************************************************************/
    /*                                       CONSTRUCTOR                                        */
    /********************************************************************************************/

    constructor() public {
        contractOwner = msg.sender;
    }

    /********************************************************************************************/
    /*                                       FUNCTION MODIFIERS                                 */
    /********************************************************************************************/

    modifier requireContractOwner() {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }

    modifier requireIsOperational() {
        require(operational, "Contract not operational");
        _;
    }

    /********************************************************************************************/
    /*                                       UTILITY FUNCTIONS                                  */
    /********************************************************************************************/

    function isUserRegistered(address account)
        external
        view
        returns (bool)
    {
        require(account != address(0), "'account' must be a valid address.");
        return userProfiles[account].isRegistered;
    }

    function isOperational()
        public
        view
        returns (bool)
    {
        return operational;
    }

    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

    function setOperatingStatus(bool mode)
        external
        requireIsOperational
    {
        require(mode != operational, "New mode must be different from existing mode");  //require that you dont change mode to something it is not
        require(userProfiles[msg.sender].isAdmin, "Caller is not an admin"); // only allow asAdmin users to call function

        bool isDuplicate = false;
        for(uint c=0; c<multiCalls.length; c++) {                      // for loop running through muticalls length
            if (multiCalls[c] == msg.sender) {                         // array run through  
                isDuplicate = true;                                    // did msg.sender already call array
                break;                                                 // exit loop if they did already call array
            }                                                          // max array of 10 - 20 item, higher tham 100 means block gas limit reached
        }
        require(!isDuplicate, "Caller has already called this function.");

        multiCalls.push(msg.sender);                                   
        if (multiCalls.length >= M) {           // if multicalls addresses are great than 2
            operational = mode;                 // change mode
            multiCalls = new address[](0);      // reset multicalls to 0
        }
    }

    function registerUser(address account, bool isAdmin)
        external
        requireContractOwner
        requireIsOperational
    {
        require(!userProfiles[account].isRegistered, "User is already registered.");

        userProfiles[account] = UserProfile({
            isRegistered: true,
            isAdmin: isAdmin
        });
    }
}
