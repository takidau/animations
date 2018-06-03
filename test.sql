12:10> SELECT TABLE COALESCE(         12:00> SELECT STREAM COALESCE(Left.N_M, 
       Left.N_M, Right.N_M) as N_M,          Right.N_M) as N_M, leftNM.Id as L, 
       leftNM.Id as L, Right.Id as R,        RightNM.Id as R, Sys.EmitTime as Time, 
       FROM LeftNM FULL OUTER JOIN           Sys.Undo as Undo, FROM LeftNM 
       RightNM ON                            FULL OUTER JOIN RightNM
       LeftNM.N_M = RightNM.N_M;             ON LeftNM.N_M = RightNM.N_M;
---------------------                 ------------------------------------
| N_M | L    | R    |                 | N_M | L    | R    | Time  | Undo |
---------------------                 ------------------------------------
| 0:1 | null | R1   |                 | 1:1 | L3   | null | 12:01 |      |
| 1:0 | L2   | null |                 | 0:1 | null | R1   | 12:02 |      |
| 1:1 | L3   | R3   |                 | 1:2 | null | R4A  | 12:03 |      |
| 1:2 | L4   | R4A  |                 | 1:2 | null | R4B  | 12:04 |      |
| 1:2 | L4   | R4B  |                 | 1:2 | null | R4A  | 12:05 | undo |
| 2:1 | L5A  | R5   |                 | 1:2 | null | R4B  | 12:05 | undo |
| 2:1 | L5B  | R5   |                 | 1:2 | L4   | R4A  | 12:05 |      |
| 2:2 | L6A  | R6A  |                 | 1:2 | L4   | R4B  | 12:05 |      |
| 2:2 | L6A  | R6B  |                 | 2:1 | null | R5   | 12:06 |      |
| 2:2 | L6B  | R6A  |                 | 1:0 | L2   | null | 12:07 |      |
| 2:2 | L6B  | R6B  |                 | 2:1 | null | R5   | 12:08 | undo |
---------------------                 | 2:1 | L5B  | R5   | 12:08 |      |
                                      | 2:1 | L5A  | R5   | 12:09 |      |
                                      | 2:2 | L6B  | null | 12:10 |      |
                                      | 2:2 | L6B  | null | 12:11 | undo |
                                      | 2:2 | L6B  | R6A  | 12:11 |      |
                                      | 2:2 | L6A  | R6A  | 12:12 |      |
                                      | 2:2 | L6A  | R6B  | 12:13 |      |
                                      | 2:2 | L6B  | R6B  | 12:13 |      |
                                      | 1:1 | L3   | null | 12:14 | undo |
                                      | 1:1 | L3   | R3   | 12:14 |      |
                                      ...
