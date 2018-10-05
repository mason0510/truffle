 //编写部署脚本
   var ConvertLib = artifacts.require("./ConvertLib.sol");  
     var MetaCoin = artifacts.require("./MetaCoin.sol");  
     module.exports = function(deployer) {    
           deployer.deploy(ConvertLib);      
         deployer.link(ConvertLib, MetaCoin);   
            deployer.deploy(MetaCoin);
        };   // 配置truffle.js   
     // Allow us to use ES6 in our migrations and tests    
 