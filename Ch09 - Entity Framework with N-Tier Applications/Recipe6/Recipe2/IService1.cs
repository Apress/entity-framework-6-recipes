using System.ServiceModel;

namespace Recipe2
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {
        [OperationContract]
        Order InsertOrder();

        [OperationContract]
        void UpdateOrderWithoutRetrieving(Order order);

        [OperationContract]
        void UpdateOrderByRetrieving(Order order);
    }
}