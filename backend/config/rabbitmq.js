
import amqp from "amqplib"

let channel

const sleep = (ms) => new Promise((res) => setTimeout(res, ms))

const connectRabbitMQ = async (retries = 10) => {
  try {
    const connection = await amqp.connect(process.env.RABBITMQ_URL)
    channel = await connection.createChannel()

     await channel.assertExchange("order.direct", "direct", { durable: true })

    console.log("RabbitMQ connected")
  } catch (err) {
    console.log("RabbitMQ not ready, retrying...", retries)

    if (retries === 0) {
      throw err
    }

    await sleep(3000)
    return connectRabbitMQ(retries - 1)
  }
}

const getChannel = () => {
  if (!channel) {
    throw new Error("RabbitMQ channel not established")
  }
  return channel
}

export { connectRabbitMQ, getChannel }  