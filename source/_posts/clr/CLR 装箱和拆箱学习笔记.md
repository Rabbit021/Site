title: CLR 装箱和拆箱学习笔记
date: 2019-04-12 21:25:46

tags:  [ CLR ,C# , Net]

categories: [ CLR ,C# , Net]

---

.Net中类型分成两类，**引用类型**和**值类型**，这两种类型之间转换的时候会产生**装箱**和**拆箱**操作。这两个操作到底发生了什么，有哪些问题需要注意

#### 定义

- 值类型=>引用类型 ：**装箱**
-  引用类型=>值类型 :  **拆箱**

#### 两种类型是如何分配内存的？

程序启动会有有**线程栈**，值类型的内存是分配在栈上，而引用类型的是分配在**托管堆**上，线程栈上只是存储了**对象地址**。如下图：

#### 装箱和拆箱都做了什么

```c#
using System;

namespace RabbitDemo
{
    class Program
    {
        static void Main(string[] args)
        { 
            int data = 0;
            object dataObj = data;   // 装箱
          
            Console.WriteLine(data);
            Console.WriteLine(dataObj);
        }
    }
}
```