using hajUsput.ML.DataStructures;
using Microsoft.ML;
using Microsoft.ML.Data;
using System;

public class Program
{
    static void Main()
    {
        var context = new MLContext();

        

        // Construct the data path
        string dataDirectory = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "..", "..", "..", "Data");
        string dataPath = Path.GetFullPath(Path.Combine(dataDirectory, "rides_data_DE.csv"));

        string mlDirectory = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "..", "..", "..", "MLModels");
        string modelPath = Path.GetFullPath(Path.Combine(mlDirectory, "PricePredictionModel.zip"));
        
        // Load data
        var dataView = context.Data.LoadFromTextFile<RideData>(dataPath, separatorChar: ',', hasHeader: true);

        // Split data into training and test sets
        var split = context.Data.TrainTestSplit(dataView, testFraction: 0.2);
        var trainData = split.TrainSet;
        var testData = split.TestSet;

        // Define training pipeline
        var pipeline = context.Transforms.Conversion.MapValueToKey("DepartureCity")
           .Append(context.Transforms.Conversion.MapValueToKey("DestinationCity"))
           .Append(context.Transforms.Concatenate("Features", "DistanceInKm", "DurationInMinutes", "AvailableSeats"))
           .Append(context.Transforms.NormalizeMinMax("Features"))
           .Append(context.Regression.Trainers.Sdca(labelColumnName: "Price", maximumNumberOfIterations: 100));

        // Train the model
        var model = pipeline.Fit(trainData);

        // Evaluate model
        var predictions = model.Transform(testData);
        var metrics = context.Regression.Evaluate(predictions, "Price");
        Console.WriteLine($"R^2: {metrics.RSquared}");
        Console.WriteLine($"MAE: {metrics.MeanAbsoluteError}");
        Console.WriteLine($"RMSE: {metrics.RootMeanSquaredError}");

        // Save the model
        context.Model.Save(model, trainData.Schema, modelPath);

        Console.WriteLine("Model training complete. Model saved to: " + modelPath);
    }
}
