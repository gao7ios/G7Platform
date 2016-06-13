#-*- coding: utf-8 -*-

from G7Platform.main.site.Common.G7APIReqHandlers import G7APIReqHandler
from G7Platform.main.site.Common.G7WebReqHandlers import G7WebReqHandler


class G7ListReqHandler(G7APIReqHandler):

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
                    sourceList = allList[len(allList)-currentPageCount]
                else:
                    sourceList = aList[currentPageCount:currentPageCount+pageCount]

        return sourceList

