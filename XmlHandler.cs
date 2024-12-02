using System.Xml.Serialization;

namespace CabinetMedical
{
    public static class XmlHandler
    {
        public static void SerializeToFile(Cabinet cabinet, string filePath)
        {
            XmlSerializer serializer = new(typeof(Cabinet));
            using StreamWriter writer = new(filePath);
            serializer.Serialize(writer, cabinet);
        }

        public static Cabinet DeserializeFromFile(string filePath)
        {
            XmlSerializer serializer = new(typeof(Cabinet));
            using StreamReader reader = new(filePath);
            return (Cabinet)serializer.Deserialize(reader);
        }
    }
}