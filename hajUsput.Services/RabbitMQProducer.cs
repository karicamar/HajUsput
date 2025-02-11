using RabbitMQ.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace hajUsput.Services
{
    public class RabbitMQProducer
    {
        private static IConnection? _connection;
        private static IModel? _channel;

        // Singleton pattern to ensure only one connection is created
        public RabbitMQProducer()
        {
            if (_connection == null || _connection.IsOpen == false)
            {
                var factory = new ConnectionFactory()
                {
                    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
                    Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
                    UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest",
                    Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
                };

                _connection = factory.CreateConnection();
                _channel = _connection.CreateModel();
                _channel.QueueDeclare(queue: "emailQueue", durable: true, exclusive: false, autoDelete: false, arguments: null);
            }
        }

        public void SendMessage(string message)
        {
            if (_channel == null || !_channel.IsOpen)
            {
                // Initialize the connection if it is closed or not yet initialized
                var factory = new ConnectionFactory()
                {
                    HostName = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost",
                    Port = int.Parse(Environment.GetEnvironmentVariable("RABBITMQ_PORT") ?? "5672"),
                    UserName = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest",
                    Password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest",
                };
                _connection = factory.CreateConnection();
                _channel = _connection.CreateModel();
                _channel.QueueDeclare(queue: "emailQueue", durable: true, exclusive: false, autoDelete: false, arguments: null);
            }

            var body = System.Text.Encoding.UTF8.GetBytes(message);
            _channel.BasicPublish(exchange: "", routingKey: "emailQueue", basicProperties: null, body: body);
            Console.WriteLine(" [x] Sent {0}", message);
        }

        public static void CloseConnection()
        {
            // Close the connection and channel when they are no longer needed
            _channel?.Close();
            _connection?.Close();
        }
    }
}
