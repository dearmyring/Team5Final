package com.kh.pj.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.kh.pj.entity.RecipeLikeDto;
import com.kh.pj.entity.RecipeViewDto;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.repository.SearchDao;
import com.kh.pj.vo.RecipeKeywordListSearchVO;
import com.kh.pj.vo.RecipeListVO;

@Controller
@RequestMapping("/recipe")
public class RecipeController {

   // 레시피 의존성
   @Autowired
   private RecipeDao recipeDao;

   // 검색 의존성
   @Autowired
   private SearchDao searchDao;

   // 레시피 목록
   @GetMapping("/list")
   public String recipeList(Model model) {

      // model에 조회 유형에 따른 조회 결과를 첨부
      model.addAttribute("recipeList", recipeDao.recipeList());

      return "recipe/list";
   }

   // 여기부터 레시피 디테일

   @GetMapping("/detail")
   public String recipeDetail(Model model, @RequestParam int recipeNo, HttpSession session) {

      // 본적이 있는 글인지 확인
      RecipeViewDto recipeViewDto = RecipeViewDto.builder().recipeViewId((String) session.getAttribute("loginId"))
            .recipeViewNo(recipeNo).build();

      // 내가 본 레시피 조회
      if (recipeDao.myViewRecipe(recipeViewDto) == null) {

         // 내가 본 레시피 등록
         recipeDao.insertRecipeView(recipeViewDto);
//         System.err.println("등록 실행");
      } else {
         recipeDao.updateRecipeViewTime(recipeViewDto);
//         System.err.println("수정 실행");
      }

      // 좋아요 한적이 있는지 확인
      RecipeLikeDto recipeLikeDto = RecipeLikeDto.builder().recipeLikeNo(recipeNo)
            .recipeLikeId((String) session.getAttribute("loginId")).build();

      recipeDao.recipeLikeOne(recipeLikeDto);

      model.addAttribute("recipe", recipeDao.selectDetail(recipeNo));
      model.addAttribute("like", recipeDao.recipeLikeOne(recipeLikeDto));

      return "recipe/detail";
   }

   @PostMapping("/searchList") // ajax 검색어 재료 배열값 가져오기
   public @ResponseBody String searchList(
         /* @RequestParam(value="submitList[]") List<String> submitList */
         @ModelAttribute RecipeKeywordListSearchVO vo, Model model
         ,RedirectAttributes attr, HttpSession session) {

      // 가져온 List<String> submitList를 검색어 테이블에 등록
      List<String> submitList = vo.getSubmitList();
//         System.out.println(submitList.size());
      for (int i = 0; i < submitList.size(); i++) {
         searchDao.add(submitList.get(i));
      }
      List<RecipeListVO> recipeListVO = recipeDao.recipeList();

      // 레시피의 n번째, 레시피n번째의 재료, 검색어를 반복문으로 비교해서 일치하는 재료 뽑기
      //재료가 들어가는 레시피의 총 개수?
      //int totalCount = 0;
      for (int r = 0; r < recipeListVO.size(); r++) {
         for (int i = 0; i < recipeListVO.get(r).getRecipeIngredientList().size(); i++) {
            // 레시피내 재료리스트에서 뽑아온 재료 한 개
            String ri = recipeListVO.get(r).getRecipeIngredientList().get(i).getRecipeIngredientName();

            int count = 0;

            for (int s = 0; s < vo.getSubmitList().size(); s++) {
               if (ri.equals(submitList.get(s))) {
                  count++;
               }
               //totalCount += count;
               
            }
            //충분 불충분 기준 일치하는 검색 재료수가 레시피 재료수가 일치하는지?
//            double check =  (double)(recipeListVO.get(r).getRecipeIngredientList().size());
            //충분 불충분 기준 일치하는 검색 재료수가 레시피 재료수의 70%를 충족하는지?
            double check =  (double)(recipeListVO.get(r).getRecipeIngredientList().size())*0.7;

//               System.out.println("count= " + count);
            boolean enough = count >= check;
//            System.out.println(enough);
             recipeListVO.get(r).setEnough(enough);
         }
         
//         System.out.println(r+"번째 레시피의 총 재료 수 =" +recipeListVO.get(r).getRecipeIngredientList().size());
      }
//      System.out.println("totalcount= " + totalCount);
    
      session.setAttribute("recipeListVO",recipeListVO);
      return "recipe/searchList";
   }
   
   @GetMapping("/searchList")
   //@RequestMapping(value="/searchList", method = RequestMethod.GET)
   public   String searchList2(
//          @RequestParam(value="RecipeListVO", required=false)  List<RecipeListVO> recipeListVO,
         HttpServletRequest request, Model model, HttpSession session) {
 //     Map<String, ?> inputFlashMap =  RequestContextUtils.getInputFlashMap(request);
//      if(null != inputFlashMap) {
         
//         List<RecipeListVO> recipeListVO = (List<RecipeListVO>) inputFlashMap.get("recipeListVO");
//         model.addAttribute("RecipeListVO",recipeListVO);
//         
//         System.out.println("출력 성공 ");
////         System.out.println("출력 성공 " +recipeListVO.get(0).getRecipeIngredientList().get(0).getRecipeIngredientName());
//      }            
//      else {
//         System.out.println("출력 실패 ");
      List<RecipeListVO> recipeListVO = (List<RecipeListVO>) WebUtils.getSessionAttribute(request, "recipeListVO");
//      List<RecipeListVO> recipeListVO =    (List<RecipeListVO>) session.getAttribute("recipeListVO");   
      
      model.addAttribute("recipeList",recipeListVO);
      System.out.println("출력 성공 " + recipeListVO );
      return "recipe/searchList";
   }
//   public @ResponseBody void testArray( @RequestParam(value="exampleArray[]") List<String> exampleArray,
   //@RequestMapping(value="/recipe/searchList", method = RequestMethod.GET)
}