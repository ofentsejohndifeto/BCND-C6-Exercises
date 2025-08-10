<<<<<<< HEAD
pragma solidity ^0.5.0;
=======
pragma solidity ^0.8.19;
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a

contract ExerciseC6A {

    /********************************************************************************************/
    /*                                       DATA VARIABLES                                     */
    /********************************************************************************************/

<<<<<<< HEAD
=======
    uint constant M = 2;
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
    struct UserProfile {
        bool isRegistered;
        bool isAdmin;
    }

    address private contractOwner;                  // Account used to deploy contract
    mapping(address => UserProfile) private userProfiles;   // Mapping for storing user profiles

<<<<<<< HEAD
    bool private operational = true; // Bool variable for operational control

    uint constant M = 2;

    address[] multiCalls = new address[](0);

=======
    bool private operational = true;                                    

    address[] multiCalls = new address[](0); // track all addresses that have called fucniton that needs to implement multi-partyy concesscus
    
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
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

<<<<<<< HEAD
    modifier requireIsOperational() {
        require(operational, "Contract not operational");
        _;
=======
    /**
    * @dev Modifier that requires the "operational" boolean variable to be "true"
    *      This is used on all state changing functions to pause the contract in 
    *      the event there is an issue that needs to be fixed
    */
    modifier requireIsOperational() 
    {
        require(operational, "Contract is currently not operational");
        _;  // All modifiers require an "_" which indicates where the function body will be added
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
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

<<<<<<< HEAD
    function isOperational()
        public
        view
        returns (bool)
=======
    /**
    * @dev Get operating status of contract
    *
    * @return A bool that is the current operating status
    */      
    function isOperational() 
                            public 
                            view 
                            returns(bool) 
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
    {
        return operational;
    }

<<<<<<< HEAD
=======

>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
    /********************************************************************************************/
    /*                                     SMART CONTRACT FUNCTIONS                             */
    /********************************************************************************************/

<<<<<<< HEAD
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
=======
    function registerUser
                                (
                                    address account,
                                    bool isAdmin
                                )
                                external
                                requireContractOwner
                                requireIsOperational
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
    {
        require(!userProfiles[account].isRegistered, "User is already registered.");

        userProfiles[account] = UserProfile({
            isRegistered: true,
            isAdmin: isAdmin
        });
    }
<<<<<<< HEAD
}
=======

    /**
    * @dev Sets contract operations on/off
    *
    * When operational mode is disabled, all write transactions except for this one will fail
    */    
    function setOperatingStatus
                            (
                                bool mode
                            ) 
                            external
    {
        require(mode != operational, "New mode must be different from existing mode");
        require(userProfiles[msg.sender].isAdmin, "Caller is not an admin");

        bool isDuplicate = false;
        for(uint c=0; c<multiCalls.length; c++) {
            if (multiCalls[c] == msg.sender) {  //loop through values of array of addresses that haev set teh fucniton operational to make sure they cant do it again
                isDuplicate = true;
                break;
            }
        }
        require(!isDuplicate, "Caller has already called this function.");

        multiCalls.push(msg.sender); //checks multi-party call, changes mode
        if (multiCalls.length >= M) {
            operational = mode;      
            multiCalls = new address[](0);      // reintialises funciton calls, otherwise defeats multicall concensus
        }
    }



>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
