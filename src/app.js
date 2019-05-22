const { getEmotions } = require("./emotions")
let response

exports.lambdaHandler = async (event, context) => {
  try {
    const image = event.body
    const emotions = await getEmotions(image)
    response = {
      statusCode: 200,
      body: JSON.stringify({
        message: emotions
      })
    }
  } catch (err) {
    console.log(err)
    return err
  }

  return response
}
