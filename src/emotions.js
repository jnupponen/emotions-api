const AWS = require("aws-sdk")

var rekognition = new AWS.Rekognition();

async function getEmotions(image) {
    const result =  await detectFaces(image)
    return result.FaceDetails.map(face => face.Emotions.sort((a,b) => a.Confidence - b.Confidence).pop())
}

function detectFaces(image) {
    const params = {
        Image: { /* required */
            Bytes: Buffer.from(image, "base64")
        },
        Attributes: [
            "ALL"
        ]
    };
    return rekognition.detectFaces(params).promise()
}

module.exports = {
    getEmotions
}
