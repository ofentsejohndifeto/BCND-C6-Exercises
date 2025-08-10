
var Test = require('../config/testConfig.js');

contract('ExerciseC6A', async (accounts) => {

  var config;
  before('setup contract', async () => {
    config = await Test.Config(accounts);
  });

  it('contract owner can register new user', async () => {
    
    // ARRANGE
    let caller = accounts[0]; // This should be config.owner or accounts[0] for registering a new user
<<<<<<< HEAD
    let newUser = config.testAddresses[1]; 
=======
    let newUser = config.testAddresses[0]; 
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a

    // ACT
    await config.exerciseC6A.registerUser(newUser, false, {from: caller});
    let result = await config.exerciseC6A.isUserRegistered.call(newUser); 

    // ASSERT
    assert.equal(result, true, "Contract owner cannot register new user");

  });

  // it('contract mode has changed', async () => {
  //   //ARRANGEs
  //   let caller = accounts[0];

  //   await config.exerciseC6A.setOperatingStatus(false, {from: caller});
  //   let result = await config.exerciseC6A.isOperational.call();

  // })

  it('function call is made when multi-party threshold is reached', async () => {

    let caller = accounts[0];
    
    // ARRANGE
    let admin1 = accounts[1];
    let admin2 = accounts[2];
    let admin3 = accounts[3];
<<<<<<< HEAD
    let admin4 = accounts[4];
    
    await config.exerciseC6A.registerUser(admin1, true, {from: caller});
    await config.exerciseC6A.registerUser(admin2, true, {from: caller});
    await config.exerciseC6A.registerUser(admin3, true, {from: caller});
    await config.exerciseC6A.registerUser(admin4, true, {from: caller});
    
    let startStatus = await config.exerciseC6A.isOperational.call();   // request method for operational status, cuase reiterations of test can change operational status
    let changeStatus = !startStatus;                                   // new status will be opposite

    // ACT
    await config.exerciseC6A.setOperatingStatus(changeStatus, {from: admin1}); // set new status to the changeStatus which is opposite of  change status

=======
    
    await config.exerciseC6A.registerUser(admin1, true, {from: config.owner});
    await config.exerciseC6A.registerUser(admin2, true, {from: config.owner});
    await config.exerciseC6A.registerUser(admin3, true, {from: config.owner});
    
    let startStatus = await config.exerciseC6A.isOperational.call(); 
    let changeStatus = !startStatus;

    // ACT
    await config.exerciseC6A.setOperatingStatus(changeStatus, {from: admin1});
>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
    await config.exerciseC6A.setOperatingStatus(changeStatus, {from: admin2});
    
    let newStatus = await config.exerciseC6A.isOperational.call(); 

    // ASSERT
<<<<<<< HEAD
    assert.equal(changeStatus, newStatus, "Multi-party call failed");  // compare newStatus to changeStatus

  });

=======
    assert.equal(changeStatus, newStatus, "Multi-party call failed");

  });


>>>>>>> 8181b37e910ec0f62b67ed44f34e6cb3448f736a
 
});
