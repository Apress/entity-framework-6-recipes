﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.18046
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Recipe2Client.ServiceReference1 {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="ServiceReference1.IService1")]
    public interface IService1 {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/Cleanup", ReplyAction="http://tempuri.org/IService1/CleanupResponse")]
        void Cleanup();
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/GetPostByTitle", ReplyAction="http://tempuri.org/IService1/GetPostByTitleResponse")]
        Recipe2.Post GetPostByTitle(string title);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/SubmitPost", ReplyAction="http://tempuri.org/IService1/SubmitPostResponse")]
        Recipe2.Post SubmitPost(Recipe2.Post post);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/SubmitComment", ReplyAction="http://tempuri.org/IService1/SubmitCommentResponse")]
        Recipe2.Comment SubmitComment(Recipe2.Comment comment);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IService1/DeleteComment", ReplyAction="http://tempuri.org/IService1/DeleteCommentResponse")]
        void DeleteComment(Recipe2.Comment comment);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IService1Channel : Recipe2Client.ServiceReference1.IService1, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class Service1Client : System.ServiceModel.ClientBase<Recipe2Client.ServiceReference1.IService1>, Recipe2Client.ServiceReference1.IService1 {
        
        public Service1Client() {
        }
        
        public Service1Client(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public Service1Client(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public Service1Client(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public Service1Client(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public void Cleanup() {
            base.Channel.Cleanup();
        }
        
        public Recipe2.Post GetPostByTitle(string title) {
            return base.Channel.GetPostByTitle(title);
        }
        
        public Recipe2.Post SubmitPost(Recipe2.Post post) {
            return base.Channel.SubmitPost(post);
        }
        
        public Recipe2.Comment SubmitComment(Recipe2.Comment comment) {
            return base.Channel.SubmitComment(comment);
        }
        
        public void DeleteComment(Recipe2.Comment comment) {
            base.Channel.DeleteComment(comment);
        }
    }
}