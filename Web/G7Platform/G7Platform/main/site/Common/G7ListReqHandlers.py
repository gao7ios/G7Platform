#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler


class G7ListReqHandler(G7APIReqHandler):

    def list(self, modelAllObjects=None, allCount=0, pageCount=10):
        if modelAllObjects == None:
            return None

        
        pageIndex = self.paramsJson.get('pageIndex')
        encrypt = True
        try:
            if self.get_argument("encrypt") == "0":
                encrypt = False
            else:
                encrypt = True
        except:
            encrypt = True

        if encrypt==False:
            pageIndex = 0
            try:
                pageIndex = int(self.get_argument("pageIndex"))
            except:
                pageIndex = 0

        if pageIndex == None:
            pageIndex = 0
        if type(pageIndex) != type(0):
            try:
                pageIndex = int(pageIndex)
            except:
                pageIndex = 0
        try:
            isLastPage = 0
            allCount = modelAllObjects.count()
            print("allCount:",allCount,"pageIndex:",pageIndex, "pageCount:",pageCount)
            if (pageIndex+1)*pageCount >= allCount:
                isLastPage = 1
            else:
                isLastPage = 0
            modelList = modelAllObjects[pageIndex*pageCount:(pageIndex+1)*pageCount]
            modelList = [model.toJsonDict(host="http://"+self.request.host) for model in modelList if model != None]
                
            if modelList == None:
                modelList = []
            return {
                "isLastPage":isLastPage,
                "list":modelList
            }
        except:
            return {}

    def isLastPage(self, allList=[], pageIndex=0, pageCount=10):

        isLastPage = 0
        if pageIndex == 0:
            if len(allList) <= pageCount:
                isLastPage = 1
            else:
                isLastPage = 0
        else:
            currentPageCount = pageIndex*pageCount
            if len(allList)-currentPageCount <= 0:
                isLastPage = 1
            else:
                if len(allList) <= currentPageCount+pageCount:
                    isLastPage = 1
                else:
                    isLastPage = 0

        return isLastPage

    def sourceList(self, allList=[], pageIndex=0, pageCount=10):

        sourceList = []
        if pageIndex == 0:
            if len(allList) <= pageCount:
                sourceList = allList
            else:
                sourceList = allList[:pageCount]
        else:
            currentPageCount = pageIndex*pageCount
            if len(allList)-currentPageCount <= 0:
                sourceList = []
            else:
                if len(allList) <= currentPageCount+pageCount:
                    sourceList = allList[len(allList)-currentPageCount:]
                else:
                    sourceList = allList[currentPageCount:currentPageCount+pageCount:]
        if type(sourceList) != type([]):
            sourceList = [sourceList]

        return sourceList

