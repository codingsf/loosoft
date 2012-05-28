using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace DataAnalyze
{

    public static class TcpMessagePool
    {
        private static Queue<MessageVo> MessageQueue = new Queue<MessageVo>(Max);
        public const int Max = 100000;

        /// <summary>
        /// 批量入队
        /// </summary>
        /// <param name="messages"></param>
        public static void batchInqueue(IList<MessageVo> messages)
        {
            foreach (MessageVo message in messages)
            {
                if (IsFull()) return;
                MessageQueue.Enqueue(message);
            }
        }

        /// <summary>
        /// 池数量；
        /// </summary>
        public static int Count
        {
            get
            {
                return MessageQueue.Count;
            }
        }

        /// <summary>
        /// 池是否已满
        /// </summary>
        /// <returns>true：已满</returns>
        public static bool IsFull()
        {
            if (Count >= Max)
                return true;
            else return false;
        }

        /// <summary>
        /// 池是否空
        /// </summary>
        /// <returns></returns>
        public static bool IsNull()
        {
            if (MessageQueue == null || MessageQueue.Count <= 0)
            {
                return true;
            }
            else return false;
        }

        /// <summary>
        /// 取（出队）                
        /// </summary>
        /// <returns></returns>
        public static MessageVo Dequeue()
        {
            //object locked = new object();
            //lock (locked)
            //{
                if (MessageQueue == null || MessageQueue.Count <= 0)
                    return null;
                return MessageQueue.Dequeue();
           // }
        }

        /// <summary>
        ///存（储邮件入队）
        /// </summary>
        /// <param name="mod"></param>
        /// <returns></returns>
        public static bool Enqueue(MessageVo message)
        {
            if (Count >= Max)
                return false;
            MessageQueue.Enqueue(message);
            return true;
        }

    }
}
