#!/usr/bin/env python
# coding: utf-8

# 
# **Python Blok Projesi**<p><img style="float: right;margin:5px 20px 5px 1px; max-width:250px" src="https://assets.datacamp.com/production/project_441/img/Nobel_Prize.png"></p>
# 
# <p>Nobel Ödülü belki de dünyanın en tanınmış bilimsel ödülüdür. Her yıl kimya, edebiyat, fizik, tıp, ekonomi ve barış alanlarında bilim insanlarına ve akademisyenlere verilmektedir. Bu projede, Nobel Ödülü kazananları inceleyeceğiz. </p>

# ## Proje Soruları
# 
# 1. Nobel Ödüllerini en çok kazanan ilk on ülkeyi bulunuz.
# 2. Nobel Ödüllerini kazanan ilk kadınları listeleyiniz.
# 3. Nobel Ödüllerini kazanan ilk erkekleri listeleyiniz.
# 4. Nobel ödülünü en çok kazanan ülkenin hangi yıldan itibaren hakimiyet sağladığını görselleştirip bu hakimiyette rol oynayan şeyler nelerdir? İçgörülerinizi paylaşır mısınız?
# 5. Nobel Ödülü kazananların cinsiyetlerini, yaşlarını, ödül kategorisi ve yılları kullanarak görselleştiriniz.(Her bir ödül kategorisi için ayrı grafik gösteriniz) Çıkan sonuçlara göre görseli yorumlayınız.
# 6. 1938-1945 yılı arasında Nobel Ödülü kazananların kategorilerini ve ülkelerini görselleştirip yorumlayınız.
# 7. 1947-1991 yılları arasında Nobel Ödülü kazananların kategorilerini ve ülkelerini görselleştirip yorumlayınız.(Her kategori için ayrı bir grafik olması istenmektedir)
# 8. Kimya, Edebiyat, Barış, Fizik ve Tıp kategorilerindeki 2000 sonrasındaki kişilerin ülkelerini, yaşlarını görselleştirin.(Her bir Kategori için ayrı görselleştirme yapılması istenmektedir) Veriyi yorumlayınız.
# 

# In[63]:


import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
nobel_db=pd.read_csv("nobel.csv")
nobel_db


# In[74]:


nobel_db['year'] = pd.to_datetime(nobel_db['year'], format='%Y')


nobel_db = nobel_db[(nobel_db['year'].dt.year > 2000)]


# In[75]:


nobel_db


# In[78]:


# Doğum tarihlerini datetime nesnelerine dönüştür
nobel_db['birth_date'] = pd.to_datetime(nobel_db['birth_date'], errors='coerce')

# Yaşları hesaplamak için doğum yılını alarak yeni bir sütun ekleyin
nobel_db['age_at_award'] = nobel_db['year'].dt.year - nobel_db['birth_date'].dt.year



# In[ ]:





# In[79]:


nobel_db


# In[52]:


# Görselleştirme
plt.figure(figsize=(12, 8))

# Cinsiyete göre histogram
plt.subplot(2, 2, 1)
nobel_db['sex'].value_counts().plot(kind='bar', color='skyblue')
plt.title('Cinsiyet Dağılımı')
plt.xlabel('Cinsiyet')
plt.ylabel('Kişi Sayısı')

# Yaş dağılımı
plt.subplot(2, 2, 2)
nobel_db['age_at_award'].plot(kind='hist', bins=20, color='green')
plt.title('Nobel Ödülü Kazananların Yaş Dağılımı')
plt.xlabel('Yaş')
plt.ylabel('Kişi Sayısı')

# Kategori dağılımı
plt.subplot(2, 2, 3)
nobel_db['category'].value_counts().plot(kind='bar', color='orange')
plt.title('Ödül Kategorisi Dağılımı')
plt.xlabel('Kategori')
plt.ylabel('Ödül Sayısı')

# Yıl dağılımı
plt.subplot(2, 2, 4)
nobel_db['year'].value_counts().sort_index().plot(kind='line', marker='o', color='red')
plt.title('Ödül Yılına Göre Dağılım')
plt.xlabel('Yıl')
plt.ylabel('Ödül Sayısı')

plt.tight_layout()
plt.show()


# In[ ]:





# In[ ]:





# In[80]:


# Ödül kategorilerini al
categories = nobel_db['category'].unique()

# Her kategori için ayrı grafik oluştur
for category in categories:
    category_data = nobel_db[nobel_db['category'] == category]
    
    plt.figure(figsize=(10, 6))
    
    # Cinsiyete göre histogram
    plt.subplot(2, 2, 1)
    category_data['sex'].value_counts().plot(kind='bar', color='skyblue')
    plt.title(f"{category} Kategorisinde Cinsiyet Dağılımı")
    plt.xlabel('Cinsiyet')
    plt.ylabel('Kişi Sayısı')
    
    # Yaş dağılımı
    plt.subplot(2, 2, 2)
    category_data['age_at_award'].plot(kind='hist', bins=20, color='green')
    plt.title(f"{category} Kategorisindeki Nobel Ödülü Kazananların Yaş Dağılımı")
    plt.xlabel('Yaş')
    plt.ylabel('Kişi Sayısı')
    
    # Ödül Yılına Göre Dağılım
    plt.subplot(2, 2, 3)
    category_data['year'].value_counts().sort_index().plot(kind='line', marker='o', color='red')
    plt.title(f"{category} Kategorisindeki Nobel Ödülü Kazananların Yıl Dağılımı")
    plt.xlabel('Yıl')
    plt.ylabel('Ödül Sayısı')
    
    plt.tight_layout()
    plt.show()


# In[ ]:




