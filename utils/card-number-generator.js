module.exports = function generateCardNo(lastCardNo) {
    if (!lastCardNo) {
        return "A0000"
    }
    let cardNums = parseInt(lastCardNo.substring(1, lastCardNo.length))
    if (cardNums === 9999) {
        firstLetter = String.fromCharCode(lastCardNo.charCodeAt(0) + 1)
        return firstLetter + "0000"
    }
    else if(cardNums < 9)
        return lastCardNo.charAt(0) + "000" + (cardNums + 1).toString()
    else if(cardNums < 99 && cardNums >= 9)
        return lastCardNo.charAt(0) + "00" + (cardNums + 1).toString()
    else if(cardNums < 999 && cardNums >= 99)
        return lastCardNo.charAt(0) + "0" + (cardNums + 1).toString()
    else 
        return lastCardNo.charAt(0) + (cardNums + 1).toString()
}