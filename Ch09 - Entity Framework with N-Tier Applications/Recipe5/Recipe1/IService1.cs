using System.ServiceModel;

namespace Recipe1
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        Payment InsertPayment();

        [OperationContract]
        void DeletePayment(Payment payment);
    }
}