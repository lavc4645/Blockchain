import Web3 from 'web3'; //import Wallet from './contracts/Wallet.json';

const getWeb3 = () => {
  //return new Web3('http://localhost:9545')//local ganache chain
  var web3 = null;

  try {
    web3 = new Web3('https://rinkeby.infura.io/v3/0e8622ff78a04db4beff04c5a80583a1');
  } catch (error) {
    console.log(error);
  }

  return web3;
}; // const getWallet = async web3 => {
//     const networkId = await web3.eth.net.getId();
//     const deployedNetwork = Wallet.networks[networkId];
//     return new web3.eth.Contract(Wallet.abi, deployedNetwork&& deployedNetwork.address);
// }
//0xf9CA77D25B75dC77BE1A22db45A6C51E150cC88b
//1b6e4869311726fef208cd090e55dc93f355b81d500e42c136d1a488ed523c8a
//0x11F4CC7A35dc7cBe72179532550946680FECF9D4
//2a82b8dbd64448ef30afa102d441bbf65b5f2531027f34a6491e02120cce6630
//0x900Fe264A734bDC8c9D06307332d7a150e966816
//59d1a9e5c589bc1e4029868f9c15879bfba165a116d86aa1d569d19a46620521
//https://rinkeby.infura.io/v3/0e8622ff78a04db4beff04c5a80583a1


export { getWeb3 };