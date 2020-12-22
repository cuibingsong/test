#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

typedef short int16_t;
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;

#define	M_PI		3.14159265358979323846	/* pi */
#define SAMPLERATE              (5000)   //采样率5k
#define  WINDOW_SIZE		3000     //一位300点

int16_t sinData[WINDOW_SIZE];
int16_t cosData[WINDOW_SIZE];
float sample1[3000];
void VarInit(void)
{
	uint32_t freq[2]={833,833}; 
	double wt = 2 * M_PI * freq[0] / SAMPLERATE;   //2*pi*f  
	for (int j = 0; j < WINDOW_SIZE; j++)
	{ 
		sinData[j] = (int16_t)(sin(wt * j) * 10000);  
	}  
                
	for (int t = 0; t < WINDOW_SIZE; t++)
	{
		cosData[t] = (int16_t)(cos(wt * t) * 10000);
	}
}
float FastSqrt(float a, int repeat)
{
	float abak = a;
    	int j;
	unsigned i = *(unsigned *)&a;  //把浮点类型输入的二进制表示重定义为一个整形数字的二进制表示
	i = 0x1FBD1DF5 + (i >> 1);
	a = *(float *)&i;              //把整形数字的二进制表示重定义为一个浮点数
	for (j = 0; j < repeat; j++)
	{
		a = (a * a + abak) / (2 * a);
	}
	return (a * a + abak) / (2 * a);
}
float DecodePlc(float AD_SAMPLE, int sinwt, int coswt, int chuang_size, float *sum1, float *sum2)
{
	(*sum1) += (AD_SAMPLE) * sinwt;     //论文公式（8）
	(*sum2) += (AD_SAMPLE) * coswt;     //论文公式（9）

	return FastSqrt(((*sum1) * (*sum1) + (*sum2) * (*sum2)), 1) * 0.0000001f;
}
uint32_t MalSegDecode24(void)
{     
    
	uint16_t i;
	uint32_t j;
	float DFTSumByFreqRow1=0;
	float DFTSumByFreqRow2=0;
	for (i = 0; i < 3000; i++)        
	{ 
		//******************flash查表法***********************         
		int16_t sinwt = sinData[i];   
		    
		int16_t coswt = cosData[i];  
		    
		//DFT频率幅值
		j = DecodePlc(sample1[i], sinwt, coswt, WINDOW_SIZE, &DFTSumByFreqRow1, &DFTSumByFreqRow2); //频率分组 1->783 2->883，相邻频率为一组。         
		printf("sinwt:%d coswt:%d sample:%f DFT1:%f DFTS2:%f j:%d\n",sinwt,coswt,sample1[i],DFTSumByFreqRow1,DFTSumByFreqRow2,j);
	}
	printf("dft1:%f dft2:%f\n",DFTSumByFreqRow1, DFTSumByFreqRow2);
    return j;
}
int main(int argc, char **argv)
{
	for(int i=0; i < 3000; i++)
	{
		sample1[i] = 20*cos(2*M_PI*833.33*i/5000);
	}
	VarInit();
/*
	for(int i=0; i<WINDOW_SIZE; i++)
	{
		printf("%d\t",sinData[i]);
		if(i%10>=9)
			printf("\n");
	}
*/
	uint32_t result = MalSegDecode24();
	printf("result = %d\n", result);
}



